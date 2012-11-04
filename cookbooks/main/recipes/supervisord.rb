# supervisord
package "supervisor"

service "supervisord" do
    service_name "supervisord"
    restart_command "kill -TERM $(cat /var/run/supervisord.pid) && /usr/bin/supervisord"
end

# config
template "supervisord.conf" do
  path "/etc/supervisor/supervisord.conf"
  source "supervisord.conf.erb"
  owner "root"
  mode 0644
  notifies :restart, resources(:service => "supervisord")
end