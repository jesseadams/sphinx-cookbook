#
# Cookbook Name:: sphinx
# Recipe:: libsphinxclient
#
# Copyright 2010, Alex Soto <apsoto@gmail.com>
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
sphinx_path = File.join(cache_path, "sphinx-#{node[:sphinx][:version]}-release")

bash "Install Client Sphinx" do
	cwd "#{sphinx_path}/api/libsphinxclient"
	code <<-EOH
        ./configure #{node[:sphinx][:libsphinxclient][:configure_flags].join(" ")} &&
		make &&
		make install
	EOH
end