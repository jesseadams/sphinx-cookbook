sphinx_rpm = node[:sphinx][:rpm][:name]
sphinx_rpm_url = "#{node[:sphinx][:repo][:base_url]}/#{node[:sphinx][:rpm][:name]}"

remote_file "#{Chef::Config[:file_cache_path]}/#{sphinx_rpm}" do
  source sphinx_rpm_url
  action :create_if_missing
end

if platform_family?('rhel')
  %w( unixODBC postgresql-libs mysql-libs).each do |rpm_package|
    yum_package rpm_package do
      action :install
    end
  end
end

rpm_package sphinx_rpm do
  source "#{Chef::Config[:file_cache_path]}/#{sphinx_rpm}"
  action :install
end

# delete the default config on first run
execute 'rm -f /etc/sphinx/sphinx.conf' do
  command 'rm -f /etc/sphinx/sphinx.conf'
  not_if { ::File.exist?('/etc/sphinx/conf.d') }
end

# create direcotry for providers
directory '/etc/sphinx/conf.d/' do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

# create direcotry for index
directory '/etc/sphinx/data/' do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

template '/etc/sphinx/sphinx.conf' do
  source 'sphinx.conf.erb'
  owner node[:sphinx][:user]
  group node[:sphinx][:group]
  mode '0644'
  variables(
    :install_path => node[:sphinx][:rpm][:conf_path],
    :searchd => node[:sphinx][:searchd],
    :indexer => node[:sphinx][:indexer]
  )
end
