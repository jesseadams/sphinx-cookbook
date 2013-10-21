sphinx_url = node[:sphinx][:source][:url] || "http://sphinxsearch.googlecode.com/svn"
cache_path  = Chef::Config[:file_cache_path]

subversion "sphinx" do
  repository "#{sphinx_url}/#{node[:sphinx][:source][:branch]}"
  revision node[:sphinx][:source][:revision]
  destination File.join(cache_path, 'sphinx')
  action :sync
  not_if { ::File.exist?(File.join(cache_path, 'sphinx')) }
end
