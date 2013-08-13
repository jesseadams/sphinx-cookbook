#
# Cookbook Name:: sphinx
# Recipe:: phpClient
#
# Copyright 2013, Gianluca Arbezzano <me@gianarb.it>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "build-essential"

cache_path  = Chef::Config[:file_cache_path]
sphinx_path = File.join(cache_path, "sphinx-#{node[:sphinx][:php][:version]}")
sphinx_tar = "#{sphinx_path}.tar.gz"

remote_file sphinx_tar do
  source node[:sphinx][:php][:url]
  action :create_if_missing
end

execute "Extract Php Sphinx Client source" do
  cwd cache_path
  command "tar -zxvf #{sphinx_tar}"
  not_if { ::File.exists?(sphinx_path) }
end

bash "Compile Php Client" do 
	cwd "#{sphinx_path}"
	code <<-EOH
		phpize
        ./configure &&
		make &&
		make install
		sudo apachectl restart
	EOH
end