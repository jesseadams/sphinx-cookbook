sphinx_url = node[:sphinx][:source][:url]
if sphinx_url.nil?
  if node[:sphinx][:version]
    if node[:sphinx][:version] == "0.9.9"
        source_file = "archive/sphinx-0.9.9"
    elsif node[:sphinx][:version] =~ /-[a-z]/ or node[:sphinx][:version].to_f < 1
      source_file = "sphinx-#{node[:sphinx][:version]}"
    else
      source_file = "sphinx-#{node[:sphinx][:version]}-release"
    end
  else
    source_file = "sphinx-2.0.8-release"
  end
  sphinx_url = "#{node[:sphinx][:source][:base_url]}/#{source_file}.tar.gz"
end

Chef::Log.info "#{node[:sphinx][:version]} turned into #{sphinx_url}"

cache_path  = Chef::Config[:file_cache_path]
sphinx_tar = File.join(cache_path, sphinx_url.split("/").last)

remote_file sphinx_tar do
  source sphinx_url
  action :create_if_missing
end

execute "Extract Sphinx source" do
  cwd cache_path
  command "tar xvzf #{sphinx_tar}"
  not_if { ::File.exist?(File.join(cache_path, 'sphinx')) }
end

execute "Move source directory to standardized 'sphinx'" do
  cwd cache_path
  command 'mv `ls -A1 | grep sphinx | head -1` sphinx'
  not_if { ::File.exist?(File.join(cache_path, 'sphinx')) }
end
