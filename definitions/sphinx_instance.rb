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
  include_recipe 'runit::default'
  include_recipe 'sphinx::default'

  opts = params

  runit_service "sphinx-#{params[:name]}" do
    run_template_name 'sphinx'
    default_logger    true
    cookbook          'sphinx'
    options({
      :bin_path  => '/usr/bin/searchd',
      :conf_path => '/vagrant/sphinx/sphinx.rt.conf',
      :user    => node[:sphinx][:user]
    }.merge(opts))
  end
end
