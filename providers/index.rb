def whyrun_supported?
  true
end

use_inline_resources if defined?(use_inline_resources)

action :create do
  if node[:sphinx][:install_method] == 'source'
    conf_path = "#{node[:sphinx][:source][:install_path]}/conf.d/#{new_resource.name}_index.txt"
    data_path = "#{node[:sphinx][:source][:install_path]}/data/#{new_resource.name}_index"
  else
    conf_path = "#{node[:sphinx][:conf_path]}/conf.d/#{new_resource.name}_index.txt"
    data_path = "#{node[:sphinx][:data_dir]}/#{new_resource.name}_index"
  end

  sphinx_reindex new_resource.name do
    action :nothing
  end

  service "sphinx" do
    service_name node[:sphinx][:package][:daemon]
    supports :status => true, :restart => true, :reload => true
    action [ :nothing ]
  end

  template conf_path do
    cookbook "sphinx"
    source "index.erb"
    owner node[:sphinx][:user]
    group node[:sphinx][:group]
    mode 0755
    variables :new_resource => new_resource,
        :data_path => data_path
    if new_resource.type == 'rt'
      notifies :reload, "service[sphinx]"
    else
      notifies :reindex, "sphinx_reindex[#{new_resource.name}]"
    end
  end
end

action :delete do
  if node[:sphinx][:install_method] == 'source'
    conf_path = "#{node[:sphinx][:source][:install_path]}/conf.d/#{new_resource.name}_index.txt"
  else
    conf_path = "#{node[:sphinx][:conf_path]}/conf.d/#{new_resource.name}_index.txt"
  end

  file conf_path do
    action :delete
  end
end
