if platform_family?('rhel')
  unless node[:sphinx][:package][:yum_repo].nil?
    include_recipe node[:sphinx][:package][:yum_repo]
  end
end

package "sphinx" do
  version node[:sphinx][:version] unless node[:sphinx][:version].nil?
  action :install
  package_name node[:sphinx][:package][:name]
end
