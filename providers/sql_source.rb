def whyrun_supported?
  true
end

use_inline_resources if defined?(use_inline_resources)

action :create do
  conf_dir = "#{node[:sphinx][:conf_dir]}/conf.d/#{new_resource.name}_source.txt"

  template conf_dir do
    cookbook "sphinx"
    source "sql_source.erb"
    owner node[:sphinx][:user]
    group node[:sphinx][:group]
    mode 0755
    variables :new_resource => new_resource
  end
end

action :delete do
  conf_path = "#{node[:sphinx][:conf_dir]}/conf.d/#{new_resource.name}_index.txt"

  file conf_path do
    action :delete
  end
end
