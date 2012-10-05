include_recipe "apache2"
include_recipe "apache2::mod_headers"
include_recipe "apache2::mod_deflate"
#include_recipe "apache2::mod_php5" # disable in favor of php-fpm
include_recipe "apache2::mod_fastcgi"

apache_module "actions" do
    enable true
end

execute "change-fastcgi-owner-permissions" do
    command "sudo chown vagrant /var/lib/apache2/fastcgi"
    notifies :reload, resources(:service => "apache2"), :delayed
end

execute "change-fastcgi-group-permissions" do
    command "sudo chgrp vagrant /var/lib/apache2/fastcgi"
    notifies :reload, resources(:service => "apache2"), :delayed
end

# disable default apache site
execute "disable-default-site" do
  command "sudo a2dissite default"
  notifies :reload, resources(:service => "apache2"), :delayed
end

web_app "default" do
  server_name node['hostname']
  server_aliases [node['fqdn'], "my-site.example.com"]
  docroot "/vagrant"
end