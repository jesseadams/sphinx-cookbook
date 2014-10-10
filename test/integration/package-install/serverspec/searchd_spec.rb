require_relative '../../../kitchen/data/spec_helper.rb'

if os[:family] == 'redhat'
  package_name = 'sphinx'
  data_dir = '/var/lib/sphinx'
  daemon = 'searchd'
  user = 'sphinx'
elsif ['debian', 'ubuntu'].include?(os[:family])
  package_name = 'sphinxsearch'
  data_dir = '/var/lib/sphinxsearch/data'
  daemon = 'sphinxsearch'
  user = 'sphinxsearch'
end

describe package(package_name) do
  it { should be_installed }
end 

describe service(daemon) do
  it { should be_enabled }
  it { should be_running }
end

describe file(data_dir) do
  it { should be_directory }
  it { should be_owned_by user}
  it { should be_mode 755 }
end

describe file("#{data_dir}/binlog.meta") do
  it { should be_file }
  it { should be_mode 600 }
  it { should be_owned_by user }
end

describe file("#{data_dir}/sql_index_index.spa") do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
end
