include_recipe "percona::client" if node[:sphinx][:use_percona]
include_recipe "mysql::client" if node[:sphinx][:use_mysql]
include_recipe "mariadb::client" if node[:sphinx][:use_mariadb]
include_recipe "postgresql::client" if node[:sphinx][:use_postgres]
include_recipe "sphinx::#{node[:sphinx][:install_method]}"
