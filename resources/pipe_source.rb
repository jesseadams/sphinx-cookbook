actions :create, :delete
default_action :create

attribute :name, kind_of: String, name_attribute: true, required: true
attribute :type, kind_of: String, required: true, equal_to: ['xmlpipe2']
attribute :xmlpipe_command, kind_of: String, required: true
attribute :xmlpipe_field, kind_of: [String, Array]
attribute :xmlpipe_field_string, kind_of: [String, Array]
attribute :xmlpipe_attr_uint, kind_of: [String, Array]
attribute :xmlpipe_attr_bool, kind_of: [String, Array]
attribute :xmlpipe_attr_bigint, kind_of: [String, Array]
attribute :xmlpipe_attr_float, kind_of: [String, Array]
attribute :xmlpipe_attr_multi, kind_of: [String, Array]
attribute :xmlpipe_attr_timestamp, kind_of: [String, Array]
attribute :xmlpipe_attr_string, kind_of: [String, Array]
attribute :xmlpipe_attr_json, kind_of: [String, Array]
attribute :xmlpipe_fixup_utf8, kind_of: [TrueClass, FalseClass]
