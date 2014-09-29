if platform_family?('rhel')
  unless node[:sphinx][:package][:yum_repo].nil?
    include_recipe node[:sphinx][:package][:yum_repo]
  end
elsif platform_family?('debian')
  include_recipe 'apt::default'
end

package "sphinx" do
  version node[:sphinx][:version] unless node[:sphinx][:version].nil?
  action :install
  package_name node[:sphinx][:package][:name]
end

directory "#{node[:sphinx][:conf_path]}/conf.d" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

template "#{node[:sphinx][:conf_path]}/sphinx.conf" do
  source 'sphinx.conf.erb'
  owner node[:sphinx][:user]
  group node[:sphinx][:group]
  mode '0644'
  variables(
    :install_path => node[:sphinx][:conf_path],
    :searchd => node[:sphinx][:searchd],
    :indexer => node[:sphinx][:indexer]
  )
end

if platform_family?('debian')
  file "/etc/default/sphinxsearch" do
    action :create
    owner "root"
    group "root"
    mode "0644"
    content "START=yes"
  end
end

service 'sphinx' do
  service_name node[:sphinx][:package][:daemon]
  supports :status => true, :restart => true, :reload => true
  action [ :enable ]
end
