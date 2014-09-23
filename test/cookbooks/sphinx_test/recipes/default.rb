include_recipe "sphinx::default"

# sphinx_source 'test_source' do
#   type 'xmlpipe2'
#   notifies :restart, "service[#{node[:sphinx][:package][:daemon]}]"
# end

# sphinx_index 'test_index' do
#   source 'test_source'
#   action :create
#   params 'rt_field' => %w(title content), 'rt_attr_uint' => 'gid'
#   notifies :restart, "service[#{node[:sphinx][:package][:daemon]}]"
# end

# sphinx_index 'test_index' do
#   params 'type' => 'rt', 'workers' => 1
#   action :create
#   notifies :restart, "service[#{node[:sphinx][:package][:daemon]}]"
# end

sphinx_index 'test_source' do
  type 'plain'
  blend_mode %w(trim_tail skip_pure)
  action :create
end
