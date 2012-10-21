# supervisord
package "supervisor"

service "supervisorctl" do
    service_name "supervisorctl"
    restart_command "/usr/bin/supervisorctl update && /usr/bin/supervisorctl restart all && sleep 1"
end

# config
template "supervisord.conf" do
  path "/etc/supervisord.conf"
  source "supervisord.conf.erb"
  owner "root"
  mode 0644
  notifies :restart, resources(:service => "supervisorctl")
end