include_recipe "sphinx::default"

# test preparation
node.set['mysql']['server_root_password'] = 'secret'
include_recipe 'mysql::server'
include_recipe 'database::mysql'

connection_info = {
  host: 'localhost',
  username: 'root',
  password: node['mysql']['server_root_password']  
}

mysql_database 'sphinx_test' do
  connection connection_info
  action :create
end

cookbook_file '/tmp/sphinx_test.sql' do
  source "sphinx_test.sql"
  owner "root"
  group "root"
  mode "0644"
end

mysql_database 'sphinx_test' do
  connection connection_info
  sql 'SET GLOBAL max_allowed_packet=32*1024*1024;'
  action :query
end

mysql_database 'sphinx_test' do
  connection connection_info
  sql { ::File.open('/tmp/sphinx_test.sql').read}
  action :query
end

# Testing

sphinx_index 'rt_index' do
  type 'rt'
  rt_field %w(Summary Content Keywords Pins)
  rt_attr_string 'Language'
  rt_attr_uint %w(EffectiveId Useful Visits Public)
  rt_attr_timestamp 'LastUpdated'
  rt_attr_multi 'Categories'
  morphology 'stem_enru'
  blend_mode %w(trim_tail skip_pure)
  action :create
  notifies :restart, "service[sphinx]"
end

sphinx_sql_source 'sql_source' do
  type 'mysql'
  sql_host 'localhost'
  sql_user 'root'
  sql_pass node['mysql']['server_root_password']  
  sql_db 'sphinx_test'
  sql_query 'SELECT ss.salaries_id AS id, ee.emp_no AS emp_no, TO_DAYS(ee.birth_date) AS birth_date_ts, \
            ee.first_name AS first_name, ee.last_name AS last_name, ee.gender AS gender, \
            TO_DAYS(ee.hire_date) AS hire_date_td, ss.salary AS salary, UNIX_TIMESTAMP(ss.from_date) AS from_date_ts, \
            UNIX_TIMESTAMP(ss.to_date) AS to_date_ts FROM employees ee JOIN salaries ss ON ss.emp_no=ee.emp_no'
  sql_attr_uint 'emp_no'
  sql_attr_timestamp %w(birth_date_ts from_date_ts to_date_ts)
  sql_field_string %w(first_name last_name gender)
  sql_attr_uint %w(hire_date_td salary)
end

sphinx_index 'sql_index' do
  type 'plain'
  source 'sql_source'
end
