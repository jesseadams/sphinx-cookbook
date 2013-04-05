actions :create, :delete, :reindex
default_action :reindex

attribute :name, :kind_of => String, :name_attribute => true, :required => true

attribute :source, :kind_of => String
attribute :params, :kind_of => Hash, :required => true, :default => {}

attribute :rotate, :kind_of => [TrueClass, FalseClass], :default => false
