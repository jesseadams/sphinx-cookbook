require_relative '../../../kitchen/data/spec_helper.rb'

if os[:family] == 'redhat'
  daemon = 'searchd'
  user = 'sphinx'
elsif ['debian', 'ubuntu'].include?(os[:family])
  daemon = 'sphinxsearch'
  user = 'sphinxsearch'
end
data_dir = '/opt/sphinx/var/data'

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
