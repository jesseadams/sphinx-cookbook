def whyrun_supported?
  true
end

use_inline_resources if defined?(use_inline_resources)

action :reindex do
  rotate = new_resource.rotate ? "--rotate" : ""
  config = "--config #{node[:sphinx][:conf_dir]}/sphinx.conf"
  
  execute "Reindexing #{new_resource.name}" do
    command "indexer #{config} #{rotate} #{new_resource.name}"
    environment "PATH" => "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:#{node[:sphinx][:source][:install_path]}/bin"
  end
end
