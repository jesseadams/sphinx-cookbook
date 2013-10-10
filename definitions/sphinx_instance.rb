#
# Cookbook Name:: sphinx
# Definition:: sphinx_instance
#
# Copyright 2009-2013, Opscode, Inc.
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

define :sphinx_instance do
  include_recipe 'sphinx::default'

  opts = params

  template "/etc/init.d/sphinx_#{params[:name]}" do
    source "sphinx-init.erb"
    cookbook "sphinx"
    mode 0655
    variables({
      :bin_path  => "#{node[:sphinx][:source][:install_path]}/bin/searchd",
      :conf_path => "#{node[:sphinx][:source][:install_path]}/sphinx.conf",
      :pid_file => node[:sphinx][:searchd][:pid_file],
    }.merge(opts))
  end
end
