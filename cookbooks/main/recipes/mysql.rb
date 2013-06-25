# mysql
include_recipe "openssl"

# dirty hack to make sure mysql is running
service "mysql" do
  action :start
  only_if "test -f /etc/init.d/mysql"
end

include_recipe "mysql::server"
include_recipe "mysql_charset"

template "/tmp/somefile" do
    notifies :restart, resources(:service => "mysql")
end
