def whyrun_supported?
  true
end

use_inline_resources if defined?(use_inline_resources)

action :create do
  if node[:sphinx][:install_method] == 'source'
    conf_path = "#{node[:sphinx][:install_path]}/conf.d/#{new_resource.name}_source.txt"
  else
    conf_path = "#{node[:sphinx][:package][:conf_path]}/conf.d/#{new_resource.name}_source.txt"
  end

  template conf_path do
    cookbook "sphinx"
    source "pipe_source.erb"
    owner node[:sphinx][:user]
    group node[:sphinx][:group]
    mode 0755
    variables :new_resource => new_resource
  end
end

action :delete do
  if node[:sphinx][:install_method] == 'source'
    conf_path = "#{node[:sphinx][:install_path]}/conf.d/#{new_resource.name}_index.txt"
  else
    conf_path = "#{node[:sphinx][:package][:conf_path]}/conf.d/#{new_resource.name}_index.txt"
  end

  file conf_path do
    action :delete
  end
end
