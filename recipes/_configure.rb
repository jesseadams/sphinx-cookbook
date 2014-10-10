directory "#{node[:sphinx][:conf_dir]}/conf.d" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

template "#{node[:sphinx][:conf_dir]}/sphinx.conf" do
  source 'sphinx.conf.erb'
  owner node[:sphinx][:user]
  group node[:sphinx][:group]
  mode '0644'
  variables(
    :conf_dir => node[:sphinx][:conf_dir],
    :log_dir => node[:sphinx][:log_dir],
    :run_dir => node[:sphinx][:run_dir],
    :data_dir => node[:sphinx][:data_dir]
  )
end

file "/etc/default/sphinxsearch" do
  action :create
  owner "root"
  group "root"
  mode "0644"
  content "START=yes"
  only_if { platform_family?('debian') }
end

service 'sphinx' do
  service_name node[:sphinx][:daemon]
  supports :status => true, :restart => true, :reload => true
  action [ :enable ]
end
