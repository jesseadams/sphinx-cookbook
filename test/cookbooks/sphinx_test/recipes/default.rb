include_recipe "sphinx::default"

sphinx_source 'test_source' do
  type 'rt'
end

sphinx_index 'test_index' do
  source 'default'
  action :create
end
