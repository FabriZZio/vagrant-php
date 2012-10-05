include_recipe "apache2"
include_recipe "apache2::mod_headers"
include_recipe "apache2::mod_deflate"
include_recipe "apache2::mod_php5"

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