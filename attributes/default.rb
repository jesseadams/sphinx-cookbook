# General Settings
default[:sphinx][:install_method] = 'source' # rpm, source or package
default[:sphinx][:version]        = nil
default[:sphinx][:user]           = 'root'
default[:sphinx][:group]          = 'root'
default[:sphinx][:use_mysql]      = false
default[:sphinx][:use_postgres]   = false

# Source Installation Settings
default[:sphinx][:source][:retrieve_method] = 'http' # http or svn
default[:sphinx][:source][:source_url] = 'http://sphinxsearch.com/files/sphinx-2.2.4-release.tar.gz'
default[:sphinx][:source][:url] = 'http://sphinxsearch.googlecode.com/svn'
default[:sphinx][:source][:install_path] = '/opt/sphinx'
default[:sphinx][:source][:configure_flags]       = []
default[:sphinx][:source][:extra_configure_flags] = []
default[:sphinx][:source][:branch]                = 'trunk'
default[:sphinx][:source][:revision]              = 'HEAD'

# Package installation via RPM
default[:sphinx][:rpm][:name]                  = 'sphinx-2.2.11-1.rhel7.x86_64.rpm'
default[:sphinx][:rpm][:base_url]              = 'http://sphinxsearch.com/files/'

# Package Installation Settings
default[:sphinx][:package][:name]     = nil # depends on platform_family when not explicit
default[:sphinx][:package][:yum_repo] = 'yum-epel' # yum recipe or nil

# Search daemon settings
default[:sphinx][:searchd][:listen]       = ['0.0.0.0:9312']
default[:sphinx][:searchd][:read_timeout] = 5
default[:sphinx][:searchd][:client_timeout] = 300
default[:sphinx][:searchd][:max_children] = 0
default[:sphinx][:searchd][:max_matches]  = 1000
default[:sphinx][:searchd][:query_log_format] = 'plain'
default[:sphinx][:searchd][:rt_flush_period] = 36_000
default[:sphinx][:searchd][:seamless_rotate] = 1
default[:sphinx][:searchd][:preopen_indexes] = 1
default[:sphinx][:searchd][:unlink_old] = 1
default[:sphinx][:searchd][:attr_flush_period] = 0
default[:sphinx][:searchd][:max_packet_size] = '32M'
default[:sphinx][:searchd][:mva_updates_pool] = '1M'
default[:sphinx][:searchd][:max_filters] = 256
default[:sphinx][:searchd][:max_filter_values] = 4096
default[:sphinx][:searchd][:listen_backlog] = 5
default[:sphinx][:searchd][:read_buffer] = '256K'
default[:sphinx][:searchd][:read_unhinted] = '32K'
default[:sphinx][:searchd][:max_batch_queries] = 32
default[:sphinx][:searchd][:subtree_docs_cache] = 0
default[:sphinx][:searchd][:subtree_hits_cache] = 0
default[:sphinx][:searchd][:workers] = 'threads'
default[:sphinx][:searchd][:dist_threads] = 0
default[:sphinx][:searchd][:binlog_flush] = 2
default[:sphinx][:searchd][:binlog_max_log_size] = 0
default[:sphinx][:searchd][:collation_server] = 'libc_ci'
default[:sphinx][:searchd][:collation_libc_locale] = 'C'
default[:sphinx][:searchd][:rt_flush_period] = 36_000
default[:sphinx][:searchd][:thread_stack] = '1M'
default[:sphinx][:searchd][:expansion_limit] = 0
default[:sphinx][:searchd][:watchdog] = 1
default[:sphinx][:searchd][:shutdown_timeout] = 3
default[:sphinx][:searchd][:ondisk_attrs_default] = 0
default[:sphinx][:searchd][:query_log_min_msec] = 0

# Indexer settings
default[:sphinx][:indexer][:mem_limit] = '128M'
default[:sphinx][:indexer][:max_iops] = 0
default[:sphinx][:indexer][:max_iosize] = 0
default[:sphinx][:indexer][:max_xmlpipe2_field] = '2M'
default[:sphinx][:indexer][:write_buffer] = '1M'
default[:sphinx][:indexer][:max_file_field_buffer] = '8M'
default[:sphinx][:indexer][:on_file_field_error] = 'ignore_field'
default[:sphinx][:indexer][:lemmatizer_cache] = '256K'

# Platform dependent settings
case node[:platform_family]
when 'debian'
  default[:sphinx][:package][:name] = 'sphinxsearch'
  default[:sphinx][:conf_dir] = '/etc/sphinxsearch'
  default[:sphinx][:data_dir] = '/var/lib/sphinxsearch/data'
  default[:sphinx][:log_dir] = '/var/log/sphinxsearch'
  default[:sphinx][:run_dir] = '/var/run/sphinxsearch'
  default[:sphinx][:daemon] = 'sphinxsearch'
  default[:sphinx][:user] = 'sphinxsearch'
when 'rhel'
  default[:sphinx][:package][:name] = 'sphinx'
  default[:sphinx][:conf_dir] = '/etc/sphinx'
  default[:sphinx][:data_dir] = '/var/lib/sphinx'
  default[:sphinx][:log_dir] = '/var/log/sphinx'
  default[:sphinx][:run_dir] = '/var/run/sphinx'
  default[:sphinx][:daemon] = 'searchd'
  default[:sphinx][:user] = 'sphinx'
else
  default[:sphinx][:package][:name] = 'sphinx'
  default[:sphinx][:conf_dir] = '/etc/sphinx'
  default[:sphinx][:data_dir] = '/var/lib/sphinx'
  default[:sphinx][:log_dir] = '/var/log/sphinx'
  default[:sphinx][:run_dir] = '/var/run/sphinx'
  default[:sphinx][:daemon] = 'searchd'
  default[:sphinx][:user] = 'sphinx'
end
