sphinx_rpm = node[:sphinx][:package][:name]
sphinx_rpm_url = "#{node[:sphinx][:package][:base_url]}/#{node[:sphinx][:package][:name]}"

remote_"{#Chef::Config[:file_cache_path]}/#{sphinx_rpm}" do
  source sphinx_rpm_url
  action :create_if_missing
end

rpm_package sphinx_rpm do
  source "#{Chef::Config[:file_cache_path]}/#{sphinx_rpm}"
  action :install
end

#service "searchd" do
#  supports :start => true, :stop => true, :restart => true
#  action :nothing
#end


