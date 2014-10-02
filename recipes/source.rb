include_recipe "build-essential"


if node[:sphinx][:source][:retrieve_method] == "svn"
  package "subversion" do
    action :install
  end
  
  subversion "sphinx" do
    repository "#{node[:sphinx][:source][:url]}/#{node[:sphinx][:source][:branch]}"
    revision node[:sphinx][:source][:revision]
    destination File.join(Chef::Config[:file_cache_path], 'sphinx')
    action :sync
    not_if { ::File.exist?(File.join(Chef::Config[:file_cache_path], 'sphinx')) }
  end

  execute "creates tar.gz" do
    cwd Chef::Config[:file_cache_path]
    command "tar czf #{File.join(Chef::Config[:file_cache_path], 'sphinx.tar.gz')} sphinx"
    creates File.join(Chef::Config[:file_cache_path], 'sphinx.tar.gz')
    action :run
  end

  node.set[:sphinx][:source][:source_url] = "file://#{File.join(Chef::Config[:file_cache_path], 'sphinx.tar.gz')}"
end

tar_package node[:sphinx][:source][:source_url] do
  prefix node[:sphinx][:source][:install_path]
  creates "#{node[:sphinx][:source][:install_path]}/bin/searchd"
  configure_flags [node[:sphinx][:use_mysql] ? '--with-mysql' : '--without-mysql',
                  node[:sphinx][:use_postgres] ? '--with-pgsql' : '--without-pgsql']
end

template "/etc/init.d/#{node[:sphinx][:daemon]}" do
  source "sphinx_#{node[:platform_family]}_init.erb"
  owner "root"
  group "root"
  mode "0755"
end

if platform_family?('rhel')
  group node[:sphinx][:user] do
    action :create
    gid 498
  end

  user node[:sphinx][:user] do
    action :create
    comment 'Sphinx Search'
    uid 498
    gid 'sphinx'
    home node[:sphinx][:source][:install_path]
    shell '/bin/bash'
    system true
  end
elsif platform_family?('debian')
  group node[:sphinx][:user] do
    action :create
    gid 111
  end
  
  user node[:sphinx][:user] do
    action :create
    comment 'Sphinx fulltext search service'
    uid 105
    gid 'sphinxsearch'
    home node[:sphinx][:source][:install_path]
    shell '/bin/false'
    system true 
  end
end

[node[:sphinx][:data_dir], node[:sphinx][:log_dir], node[:sphinx][:run_dir]].each do |dir|
  directory dir do
    owner node[:sphinx][:user]
    group "root"
    mode "0755"
    action :create
  end
end

include_recipe "sphinx::_configure"
