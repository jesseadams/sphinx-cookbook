include_recipe "build-essential"

cache_path  = Chef::Config[:file_cache_path]
sphinx_path = File.join(cache_path, 'sphinx')

# Setup directory structures
directory node[:sphinx][:source][:install_path] do
  recursive true
end

template "#{node[:sphinx][:source][:install_path]}/sphinx.conf" do
  source "sphinx.conf.erb"
  owner node[:sphinx][:user]
  group node[:sphinx][:group]
  mode '0644'
  variables :install_path => node[:sphinx][:source][:install_path],
            :searchd => node[:sphinx][:searchd],
            :indexer => node[:sphinx][:indexer]
end

directory "#{node[:sphinx][:source][:install_path]}/conf.d" do
  owner node[:sphinx][:user]
  group node[:sphinx][:group]
  mode '0755'
end

# Install required dependency when building from source
# against Percona server
if node[:sphinx][:use_percona]
  case node[:platform_family]
  when 'debian'
    package 'libssl-dev'
  when 'rhel'
    package 'openssl-devel'
  end
end

include_recipe "sphinx::_source_from_#{node[:sphinx][:source][:retrieve_method]}"

if node[:sphinx][:use_stemmer]
  remote_file File.join(cache_path, "libstemmer_c.tgz") do
    source node[:sphinx][:source][:stemmer_url]
    action :create_if_missing
  end

  execute "Extract libstemmer source" do
    cwd Chef::Config[:file_cache_path]
    command "tar -C #{sphinx_path} -zxf libstemmer_c.tgz"
    not_if { ::File.exists?("#{sphinx_path}/libstemmer_c/src_c") }
  end
end

# Build configure flags from attributes, unless configure flags have been
# manually specified
configure_flags = node[:sphinx][:source][:configure_flags]
if configure_flags.empty?
  configure_flags = [
    "--prefix=#{node[:sphinx][:source][:install_path]}",
    "--bindir=#{node[:sphinx][:source][:binary_path]}",
    node[:sphinx][:use_stemmer] ? '--with-libstemmer' : '--without-libstemmer',
    (node[:sphinx][:use_mysql] or node[:sphinx][:use_percona]) ? '--with-mysql' : '--without-mysql',
    node[:sphinx][:use_postgres] ? '--with-pgsql' : '--without-pgsql'
  ]
end

bash "Build and Install Sphinx Search" do
  cwd File.join(Chef::Config[:file_cache_path], 'sphinx')
  code <<-EOH
    ./configure #{configure_flags.concat(node[:sphinx][:source][:extra_configure_flags]).uniq.join(" ")} &&
    make &&
    make install
  EOH
  not_if {
    searchd_binary = ::File.join(node[:sphinx][:source][:binary_path], 'searchd')
    searchd_present = ::File.exists?(searchd_binary)
    searchd_version_correct = searchd_present

    if searchd_present and node[:sphinx][:version]
      searchd_version_correct = system("#{searchd_binary} -h | head -1 | grep -q \"#{node[:sphinx][:version]}[^\.]\"")
    end

    searchd_present && searchd_version_correct
  }
end
