include_recipe "php"

# xdebug
php_pear "xdebug" do
  zend_extensions ['xdebug.so']
  directives(:profiler_enable_trigger => 1)
  action :install
end

# apc
package "php5-apc"

# apc shm size
template "#{node['php']['ext_conf_dir']}/apc.ini" do
  source "apc.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end

# curl
package "php5-curl"

# gd
package "php5-gd"

# memcache
package "php5-memcache"

# sqlite
package "php5-sqlite"

# mysql
package "php5-mysql"

# php fpm
package "php5-fpm"

# pear phpunit channel
php_pear_channel "pear.phpunit.de" do
  action :discover
end

# pear auto-discover
execute "pear-auto-discover" do
    command "pear config-set auto_discover 1"
end

# phpunit
php_pear "PHPUnit" do
    channel "pear.phpunit.de"
    action :install
end
