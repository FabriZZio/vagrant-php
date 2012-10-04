include_recipe "php"

# xdebug
php_pear "xdebug" do
  zend_extensions ['xdebug.so']
  action :install
end

# apc
php_pear "apc" do
  action :install
  directives(:shm_size => "128M", :enable_cli => 1)
end

# curl
package "php5-curl"

# gd
package "php5-gd"

# memcache
package "php5-memcache"

# sqlite
php_pear "sqlite" do
  action :install
end