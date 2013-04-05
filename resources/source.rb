actions :create, :delete
default_action :create

attribute :name, :kind_of => String, :name_attribute => true, :required => true

attribute :type, :kind_of => String, :equal_to => ["pgsql", "mysql", "mssql", "xmlpipe", "xmlpipe2", "odbc"]
attribute :params, :kind_of => Hash, :required => true, :default => {}
