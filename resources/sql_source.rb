actions :create, :delete
default_action :create

attribute :name, kind_of: String, name_attribute: true, required: true
attribute :type, kind_of: String, required: true, equal_to: %w(mysql pgsql mssql)
attribute :sql_host, required: true
attribute :sql_port, kind_of: Integer
attribute :sql_user, kind_of: String
attribute :sql_pass, kind_of: String
attribute :sql_db, kind_of: String
attribute :sql_sock, kind_of: String
attribute :mysql_connect_flags, kind_of: Integer
attribute :mysql_ssl_cert, kind_of: String
attribute :mysql_ssl_key, kind_of: String
attribute :mysql_ssl_ca, kind_of: String
attribute :sql_query_pre, kind_of: [String, Array]
attribute :sql_query, kind_of: String, required: true
attribute :sql_joined_field, kind_of: [String, Array]
attribute :sql_query_range, kind_of: String
attribute :sql_range_step, kind_of: Integer
attribute :sql_query_killlist, kind_of: String
attribute :sql_attr_uint, kind_of: [String, Array]
attribute :sql_attr_bool, kind_of: [String, Array]
attribute :sql_attr_bigint, kind_of: [String, Array]
attribute :sql_attr_timestamp, kind_of: [String, Array]
attribute :sql_attr_float, kind_of: [String, Array]
attribute :sql_attr_multi, kind_of: [String, Array]
attribute :sql_attr_string, kind_of: [String, Array]
attribute :sql_attr_json, kind_of: [String, Array]
attribute :sql_field_string, kind_of: [String, Array]
attribute :sql_file_field, kind_of: String
attribute :sql_query_post, kind_of: String
attribute :sql_query_post_index, kind_of: String
attribute :sql_ranged_throttle, kind_of: Integer
attribute :mssql_winauth, kind_of: [TrueClass, FalseClass]
