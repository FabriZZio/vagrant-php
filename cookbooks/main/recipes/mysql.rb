# mysql
include_recipe "openssl"
include_recipe "mysql::server"
include_recipe "mysql_charset"