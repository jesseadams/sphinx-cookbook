def whyrun_supported?
  true
end

use_inline_resources if defined?(use_inline_resources)

action :reindex do
  execute "Reindexing #{new_resource.name}" do
    rotate = new_resource.rotate ? "--rotate" : ""
    config = "--config #{node[:sphinx][:conf_path]}/sphinx.conf"
    command "indexer #{config} #{rotate} #{new_resource.name}"
  end
end
