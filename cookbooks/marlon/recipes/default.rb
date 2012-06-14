# overwrite default php.ini with custom one
template "/etc/php5/conf.d/custom.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources("service[apache2]"), :delayed
end

# xdebug package
php_pear "xdebug" do
  action :install
end

# xdebug template
template "/etc/php5/conf.d/xdebug.ini" do
  source "xdebug.ini.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources("service[apache2]"), :delayed
end

# php5 mysql
package "php5-mysql" do
  action :install
  notifies :restart, resources("service[apache2]"), :delayed
end

# memcached
package "memcached"

# memcache
php_pear "memcache" do
  action :install
end

# disable default apache site
execute "disable-default-site" do
  command "sudo a2dissite default"
  notifies :reload, resources(:service => "apache2"), :delayed
end

# configure apache project vhost
web_app "project" do
  template "project.conf.erb"
  server_name node['hostname']
  server_aliases node['aliases']
  docroot "/vagrant/public"
  set_env node['set_env']
end

# install PHPUnit
execute "pear-discover" do
  command "sudo pear config-set auto_discover 1"
end

# upgrade pear
execute "pear-upgrade" do
  command "sudo pear upgrade pear"
end

execute "phpunit" do
  command "sudo pear install pear.phpunit.de/PHPUnit"
  not_if "phpunit -v | grep 3.6"
end


# install git
package "git-core"

# phpMyAdmin
script "install_phpmyadmin" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  rm -rf /tmp/phpMyAdmin*

  wget http://sourceforge.net/projects/phpmyadmin/files/phpMyAdmin/3.5.0/phpMyAdmin-3.5.0-english.tar.gz
  tar -xzvf phpMyAdmin-3.5.0-english.tar.gz

  mkdir -p /var/www/phpmyadmin
  cp -R /tmp/phpMyAdmin-3.5.0-english/* /var/www/phpmyadmin/

  EOH
  not_if "test -f /var/www/phpmyadmin"
end

# capistrano
script "install_capistrano" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  gem sources -a http://gems.github.com/
  gem install capistrano
  gem install capistrano-ext

  git clone git@github.com:marlon-be/fratello-deploy-strategy.git
  cd fratello-deploy-strategy
  gem build fratello.gemspec
  gem install fratello-0.0.2.gem

  cd ..
  git clone https://github.com/ursm/capistrano-notification.git
  cd capistrano-notification
  gem build capistrano-notification.gemspec
  gem install capistrano-notification-0.1.1.gem
  gem install sr-shout-bot --source=http://gems.github.com

  EOH
end