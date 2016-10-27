def whyrun_supported?
  true
end

use_inline_resources if defined?(use_inline_resources)

action :create do
  conf_dir = "#{node[:sphinx][:conf_dir]}/conf.d/#{new_resource.name}_index.txt"
  data_path = "#{node[:sphinx][:data_dir]}/#{new_resource.name}_index"

  sphinx_reindex new_resource.name do
    action :nothing
  end

  service 'sphinx' do
    service_name node[:sphinx][:daemon]
    supports status: true, restart: true, reload: true
    action [:nothing]
  end

  template conf_dir do
    cookbook 'sphinx'
    source 'index.erb'
    owner node[:sphinx][:user]
    group node[:sphinx][:group]
    mode 0755
    variables new_resource: new_resource,
              data_path: data_path
    if new_resource.type == 'rt'
      notifies :reload, 'service[sphinx]'
    else
      notifies :reindex, "sphinx_reindex[#{new_resource.name}]"
    end
  end
end

action :delete do
  conf_path = "#{node[:sphinx][:conf_dir]}/conf.d/#{new_resource.name}_index.txt"

  file conf_path do
    action :delete
  end
end
