def whyrun_supported?
  true
end

use_inline_resources if defined?(use_inline_resources)

action :create do
  if node[:sphinx][:install_method] == 'source'
    conf_path = "#{node[:sphinx][:source][:install_path]}/conf.d/#{new_resource.name}_index.txt"
    data_path = "#{node[:sphinx][:source][:install_path]}/data/#{new_resource.name}_index"
  else
    conf_path = "#{node[:sphinx][:package][:conf_path]}/conf.d/#{new_resource.name}_index.txt"
    data_path = "#{node[:sphinx][:data_dir]}/#{new_resource.name}_index"
  end

  template conf_path do
    cookbook "sphinx"
    source "index.erb"
    owner node[:sphinx][:user]
    group node[:sphinx][:group]
    mode 0755
    variables :new_resource => new_resource,
        :data_path => data_path
  end
end

# action :reindex do
#     execute "Reindexing #{new_resource.name}" do
#         rotate = new_resource.rotate ? "--rotate" : ""
#         config = "--config #{node[:sphinx][:install_path]}/sphinx.conf"
#         command "indexer #{config} #{rotate} #{new_resource.name}"
#     end

#     new_resource.updated_by_last_action(true)
# end

action :delete do
  if node[:sphinx][:install_method] == 'source'
    conf_path = "#{node[:sphinx][:source][:install_path]}/conf.d/#{new_resource.name}_index.txt"
  else
    conf_path = "#{node[:sphinx][:package][:conf_path]}/conf.d/#{new_resource.name}_index.txt"
  end

  file conf_path do
    action :delete
  end
end
