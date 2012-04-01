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
  docroot "/vagrant"
  set_env node['set_env']
end

# upgrade PEAR to latest version
execute "upgrade-pear" do
  command "sudo pear upgrade pear"
end

# install PHPUnit
execute "pear-discover" do
  command "sudo pear config-set auto_discover 1"
end

execute "phpunit" do
  command "sudo pear install pear.phpunit.de/PHPUnit"
end

# install ant (for deployment)
package "ant"

# install unzip
package "unzip"

# oracle instantclient
script "install_instantclient" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  rm -rf /tmp/instantclient*
  wget --load-cookies=/vagrant/oracle-cookie.txt http://download.oracle.com/otn/linux/instantclient/11203/instantclient-basic-linux.x64-11.2.0.3.0.zip
  unzip instantclient-basic-linux.x64-11.2.0.3.0.zip
  
  wget --load-cookies=/vagrant/oracle-cookie.txt http://download.oracle.com/otn/linux/instantclient/11203/instantclient-sqlplus-linux.x64-11.2.0.3.0.zip
  unzip instantclient-sqlplus-linux.x64-11.2.0.3.0.zip
  
  wget --load-cookies=/vagrant/oracle-cookie.txt http://download.oracle.com/otn/linux/instantclient/11203/instantclient-sdk-linux.x64-11.2.0.3.0.zip
  unzip instantclient-sdk-linux.x64-11.2.0.3.0.zip
  
  mkdir -p /usr/local/instantclient
  rm -rf /usr/local/instantclient/*
  cp -R instantclient_11_2/* /usr/local/instantclient/
  cd /usr/local/instantclient
  ln -s libclntsh.so.11.1 libclntsh.so
  ln -s libocci.so.11.1 libocci.so
  
  echo 'export ORACLE_HOME=/usr/local/instantclient' >> /etc/profile
  echo 'export DYLD_LIBRARY_PATH=/usr/local/instantclient' >> /etc/profile
  
  EOH
  not_if "test -f /usr/local/instantclient"
end

# libaio requirement oci8
package "libaio1"

# php oci8
script "oci8" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  echo 'instantclient,/usr/local/instantclient' | sudo pecl install oci8
  echo '
  extension=oci8.so' >> /etc/php5/conf.d/custom.ini
  EOH
end

# todo:
# apache /pma alias: "project.local/pma"