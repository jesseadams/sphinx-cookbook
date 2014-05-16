# General Settings
default[:sphinx][:install_method] = 'source' # source or package
default[:sphinx][:version]        = nil
default[:sphinx][:user]           = 'root'
default[:sphinx][:group]          = 'root'
default[:sphinx][:use_stemmer]    = false
default[:sphinx][:use_mysql]      = false
default[:sphinx][:use_percona]    = false
default[:sphinx][:use_postgres]   = false

# Source Installation Settings
default[:sphinx][:source][:retrieve_method]       = 'http' # http or svn
default[:sphinx][:source][:url]                   = nil
default[:sphinx][:source][:base_url]              = "http://sphinxsearch.com/files"
default[:sphinx][:source][:stemmer_url]           = "http://snowball.tartarus.org/dist/libstemmer_c.tgz"
default[:sphinx][:source][:install_path]          = "/usr/local"
default[:sphinx][:source][:binary_path]           = "#{sphinx[:source][:install_path]}/bin"
default[:sphinx][:source][:configure_flags]       = []
default[:sphinx][:source][:extra_configure_flags] = []
default[:sphinx][:source][:branch]                = 'trunk'
default[:sphinx][:source][:revision]              = 'HEAD'

# Package Installation Settings
default[:sphinx][:package][:name]     = nil # depends on platform_family when not explicit
default[:sphinx][:package][:yum_repo] = 'yum-epel' # yum recipe or nil

# Search daemon settings
default[:sphinx][:searchd][:listen]       = ["0.0.0.0:9312"]
default[:sphinx][:searchd][:log]          = "/var/log/sphinx/sphinx.log"
default[:sphinx][:searchd][:query_log]    = "/var/log/sphinx/query.log"
default[:sphinx][:searchd][:pid_file]     = "/tmp/sphinx.pid"
default[:sphinx][:searchd][:read_timeout] = 5
default[:sphinx][:searchd][:max_children] = 30
default[:sphinx][:searchd][:max_matches]  = 1000

# Indexer settings
default[:sphinx][:indexer][:mem_limit]             = "32M"
default[:sphinx][:indexer][:write_buffer]          = "1M"
default[:sphinx][:indexer][:max_file_field_buffer] = "8M"
