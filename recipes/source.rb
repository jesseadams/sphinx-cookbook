include_recipe "build-essential"


ark "sphinx" do
  url  node[:sphinx][:source][:source_url]
  version /[0-9]+.[0-9]+.[0-9]+/.match(node[:sphinx][:source][:source_url]).to_s
  autoconf_opts ["--exec-prefix=#{node[:sphinx][:source][:install_path]}",
                "--prefix=#{node[:sphinx][:source][:install_path]}",
                node[:sphinx][:use_stemmer] ? '--with-libstemmer' : '--without-libstemmer',
                node[:sphinx][:use_mysql] ? '--with-mysql' : '--without-mysql',
                node[:sphinx][:use_postgres] ? '--with-pgsql' : '--without-pgsql']
  action :install_with_make
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

directory node[:sphinx][:data_dir] do 
  owner node[:sphinx][:user]
  group "root"
  mode "0755"
  action :create
end

directory node[:sphinx][:log_dir] do
  owner node[:sphinx][:user]
  group "root"
  mode "0755"
  action :create
end

directory node[:sphinx][:run_dir] do
  owner node[:sphinx][:user]
  group "root"
  mode "0755"
  action :create
end

include_recipe "sphinx::_configure"
