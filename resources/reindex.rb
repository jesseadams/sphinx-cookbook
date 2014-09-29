actions :reindex
default_action :reindex

attribute :name, :kind_of => String, :name_attribute => true, :required => true
attribute :rotate, :kind_of => [TrueClass, FalseClass], :default => true