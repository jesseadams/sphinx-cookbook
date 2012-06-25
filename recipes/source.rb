#
# Cookbook Name:: sphinx
# Recipe:: source
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

sphinx_path = "/tmp/sphinx-#{node[:sphinx][:version]}-release"
sphinx_tar = "#{sphinx_path}.tar.gz"

remote_file sphinx_tar do
  source "#{node[:sphinx][:url]}"
  not_if { ::File.exists?(sphinx_tar) }
end

execute "Extract Sphinx source" do
  cwd "/tmp"
  command "tar -zxvf #{sphinx_tar}"
  not_if { ::File.exists?(sphinx_path) }
end

if node[:sphinx][:use_stemmer]
  remote_file "/tmp/libstemmer_c.tgz" do
    source node[:sphinx][:stemmer_url]
    not_if { ::File.exists?("/tmp/libstemmer_c.tgz") }
  end

  execute "Extract libstemmer source" do
    cwd "/tmp"
    command "tar -C #{sphinx_path} -zxf libstemmer_c.tgz"
    not_if { ::File.exists?("#{sphinx_path}/libstemmer_c/src_c") }
  end
end

bash "Build and Install Sphinx Search" do
  cwd sphinx_path
  # use trailing && to break on the first thing.
  # Otherwise the whole block depends on the last line
  code <<-EOH
    ./configure #{node[:sphinx][:configure_flags].join(" ")} &&
    make &&
    make install
  EOH
  not_if { ::File.exists?("/usr/local/bin/searchd") }
  # add additional test to verify of searchd is same as version of sphinx we are installing
  #  && system("#{node[:sphinx][:install_path]}/bin/ree-version | grep -q '#{node[:sphinx][:version]}$'")
end

