#
# Cookbook Name:: sphinx
# Recipe:: default
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
include_recipe "mysql::client" if node[:sphinx][:use_mysql]
include_recipe "postgresql::client" if node[:sphinx][:use_postgres]

remote_file "/tmp/sphinx-#{node[:sphinx][:version]}.tar.gz" do
  source "#{node[:sphinx][:url]}"
  not_if { ::File.exists?("/tmp/sphinx-#{node[:sphinx][:version]}.tar.gz") }
end

execute "Extract Sphinx source" do
  cwd "/tmp"
  command "tar -zxvf /tmp/sphinx-#{node[:sphinx][:version]}.tar.gz"
  not_if { ::File.exists?("/tmp/sphinx-#{node[:sphinx][:version]}") }
end

if node[:sphinx][:use_stemmer] 
  remote_file "/tmp/libstemmer_c.tgz" do
    source node[:sphinx][:stemmer_url]
    not_if { ::File.exists?("/tmp/libstemmer_c.tgz") }
  end

  execute "Extract libstemmer source" do
    cwd "/tmp"
    command "tar -C /tmp/sphinx-#{node[:sphinx][:version]} -zxf libstemmer_c.tgz"
    not_if { ::File.exists?("/tmp/sphinx-#{node[:sphinx][:version]}/libstemmer_c/src_c") }
  end
end

bash "Build and Install Sphinx Search" do
  cwd "/tmp/sphinx-#{node[:sphinx][:version]}"
  code <<-EOH
    ./configure #{node[:sphinx][:configure_flags].join(" ")}
    make
    make install
  EOH
  not_if { ::File.exists?("/usr/local/bin/searchd") }
  # add additional test to verify of searchd is same as version of sphinx we are installing
  #  && system("#{node[:sphinx][:install_path]}/bin/ree-version | grep -q '#{node[:sphinx][:version]}$'")
end

