package "libaio1"
package "alien"

script "copy_oracle_sources" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  cp /vagrant/resources/oracle-instantclient11.2-* /tmp/
  EOH
end

script "alienate_oracle_rpm" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH

  alien -i oracle-instantclient11.2-basic*.rpm
  alien -i oracle-instantclient11.2-sqlplus*.rpm
  alien -i oracle-instantclient11.2-devel*.rpm

  EOH
  not_if "test -f /usr/bin/sqlplus64"
end

template "oracle.conf" do
  path "/etc/ld.so.conf.d/oracle.conf"
  source "oracle.conf.erb"
  owner "root"
  mode 0644
end

script "restart_ldconfig" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  ldconfig
  EOH
end

# php oci8
script "oci8" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  sudo pecl install oci8
  echo '
  extension=oci8.so' >> /etc/php5/conf.d/custom.ini
  EOH
end