def whyrun_supported?
  true
end

use_inline_resources if defined?(use_inline_resources)

action :create do
  if node[:sphinx][:install_method] == 'source'
    conf_path = "#{node[:sphinx][:install_path]}/conf.d/#{new_resource.name}_index.txt"
    data_path = "#{node[:sphinx][:install_path]}/data/#{new_resource.name}_index"
  else
    conf_path = "#{node[:sphinx][:package][:conf_path]}/conf.d/#{new_resource.name}_index.txt"
    data_path = "#{node[:sphinx][:package][:data_dir]}/#{new_resource.name}_index"
  end

  template conf_path do
      cookbook "sphinx"
      source "source.erb"
      owner node[:sphinx][:user]
      group node[:sphinx][:group]
      mode 0755
      variables :new_resource => new_resource
  end

  new_resource.updated_by_last_action(true)
end

action :delete do
  if node[:sphinx][:install_method] == 'source'
    conf_path = "#{node[:sphinx][:install_path]}/conf.d/#{new_resource.name}_index.txt"
  else
    conf_path = "#{node[:sphinx][:package][:conf_path]}/conf.d/#{new_resource.name}_index.txt"
  end

  conf_path = "#{node[:sphinx][:install_path]}/conf.d/#{new_resource.name}_source.txt"

  execute "Deleting #{new_resource.name}" do
    command "rm #{conf_path}"
  end

  new_resource.updated_by_last_action(true)
end
