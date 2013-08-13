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

# Set the correct download URL for the requested version of sphinx, accounting
# for nonstandard URLs, old versions, and beta releases, provided that a default
# value does not already exist for the URL
sphinx_url = node[:sphinx][:url]
if sphinx_url.nil?
  if node[:sphinx][:version]
    if node[:sphinx][:version] == "0.9.9"
        source_file = "archive/sphinx-0.9.9"
    elsif node[:sphinx][:version] =~ /-[a-z]/ or node[:sphinx][:version].to_f < 1
      source_file = "sphinx-#{node[:sphinx][:version]}"
    else
      source_file = "sphinx-#{node[:sphinx][:version]}-release"
    end
  else
    source_file = "sphinx-2.0.8-release"
  end
  sphinx_url = "#{node[:sphinx][:base_url]}/#{source_file}.tar.gz"
end

cache_path  = Chef::Config[:file_cache_path]
sphinx_tar = File.join(cache_path, sphinx_url.split("/").last)
sphinx_path = sphinx_tar.sub(/\.tar\.gz$/, "")

remote_file sphinx_tar do
  source sphinx_url
  action :create_if_missing
end

execute "Extract Sphinx source" do
  cwd cache_path
  command "tar -zxvf #{sphinx_tar}"
  not_if { ::File.exists?(sphinx_path) }
end

if node[:sphinx][:use_stemmer]
  remote_file File.join(cache_path, "libstemmer_c.tgz") do
    source node[:sphinx][:stemmer_url]
    action :create_if_missing
  end

  execute "Extract libstemmer source" do
    cwd cache_path
    command "tar -C #{sphinx_path} -zxf libstemmer_c.tgz"
    not_if { ::File.exists?("#{sphinx_path}/libstemmer_c/src_c") }
  end
end

# Build configure flags from attributes, unless configure flags have been
# manually specified
configure_flags = node[:sphinx][:configure_flags]
if configure_flags.nil?
  configure_flags = [
    "--prefix=#{node[:sphinx][:install_path]}",
    node[:sphinx][:use_stemmer] ? '--with-libstemmer' : '--without-libstemmer',
    node[:sphinx][:use_mysql] ? '--with-mysql' : '--without-mysql',
    node[:sphinx][:use_postgres] ? '--with-pgsql' : '--without-pgsql'
  ]
end

bash "Build and Install Sphinx Search" do
  cwd sphinx_path
  # use trailing && to break on the first thing.
  # Otherwise the whole block depends on the last line
  code <<-EOH
    ./configure #{configure_flags.concat(node[:sphinx][:extra_configure_flags]).uniq.join(" ")} &&
    make &&
    make install
  EOH
  not_if { ::File.exists?( ::File.join(node[:sphinx][:install_path],'bin','searchd') ) }
  # add additional test to verify of searchd is same as version of sphinx we are installing
  #  && system("#{node[:sphinx][:install_path]}/bin/ree-version | grep -q '#{node[:sphinx][:version]}$'")
end

