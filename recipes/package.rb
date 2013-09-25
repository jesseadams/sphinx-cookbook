default_package_name = case node[:platform_family]
when 'debian'
  'sphinxsearch'
when 'rhel'
  unless node[:sphinx][:package][:yum_repo].nil?
    include_recipe node[:sphinx][:package][:yum_repo]
  end

  'sphinx'
else
  'sphinx'
end

sphinx_package_name = node[:sphinx][:package][:name] || default_package_name

package "sphinx" do
  version node[:sphinx][:version] unless node[:sphinx][:version].nil?
  action :install
  package_name sphinx_package_name
end
