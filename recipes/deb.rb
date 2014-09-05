sphinx_deb = node[:sphinx][:deb][:name] % {
  version: node[:sphinx][:version],
  codename: node[:lsb][:codename],
  arch: node[:kernel][:machine] == 'x86_64' ? 'amd64' : 'i386'
}
sphinx_deb_url = "#{node[:sphinx][:repo][:base_url]}#{sphinx_deb}"

remote_file "#{Chef::Config[:file_cache_path]}/#{sphinx_deb}" do
  source sphinx_deb_url
  action :create_if_missing
end

file '/etc/default/sphinxsearch' do
  content "START=#{node[:sphinx][:deb][:autostart]}"
  owner 'root'
  group 'root'
  mode 0644
end

dpkg_package sphinx_deb do
  source "#{Chef::Config[:file_cache_path]}/#{sphinx_deb}"
  action :install
  options '--force-confold'
end

base_conf_dir = node[:sphinx][:deb][:conf_path]
directory "#{base_conf_dir}/conf.d" do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

base_var_dir = node[:sphinx][:deb][:var_path]
directory "#{base_var_dir}/data" do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

template "#{base_conf_dir}/sphinx.conf" do
  source 'sphinx.conf.erb'
  owner node[:sphinx][:user]
  group node[:sphinx][:group]
  mode '0644'
  variables(
    :install_path => node[:sphinx][:deb][:conf_path],
    :searchd => node[:sphinx][:searchd],
    :indexer => node[:sphinx][:indexer]
  )
end
