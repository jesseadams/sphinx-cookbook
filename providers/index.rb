action :create do

    conf_path = "#{node[:sphinx][:install_path]}/conf.d/#{new_resource.name}_index.txt"
    data_path = "#{node[:sphinx][:install_path]}/data/#{new_resource.name}_index"

    template conf_path do
        cookbook "sphinx"
        source "index.erb"
        owner node[:sphinx][:user]
        group node[:sphinx][:group]
        mode 0755
        variables :new_resource => new_resource,
            :data_path => data_path
    end

    new_resource.updated_by_last_action(true)
end


action :reindex do
    execute "Reindexing #{new_resource.name}" do
        rotate = new_resource.rotate ? "--rotate" : ""
        config = "--config #{node[:sphinx][:install_path]}/sphinx.conf"
        command "indexer #{config} #{rotate} #{new_resource.name}"
    end

    new_resource.updated_by_last_action(true)
end

action :delete do

    conf_path = "#{node[:sphinx][:install_path]}/conf.d/#{new_resource.name}_index.txt"

    execute "Deleting #{new_resource.name}" do
        command "rm #{conf_path}"
    end

    new_resource.updated_by_last_action(true)
end
