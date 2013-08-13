default[:sphinx][:use_package]  = false
default[:sphinx][:install_path] = "/opt/sphinx"
default[:sphinx][:version]      = nil
default[:sphinx][:package_name] = nil # depends on platform_family when not explicit
default[:sphinx][:url]          = "http://sphinxsearch.com/files/sphinx-#{sphinx[:version]}-release.tar.gz"
default[:sphinx][:stemmer_url]  = "http://snowball.tartarus.org/dist/libstemmer_c.tgz"
default[:sphinx][:user]         = 'root'
default[:sphinx][:group]        = 'root'

# when installing package in RHEL/CentOS include yum::epel by default
# set to 'nil' to not include recipes before installing sphinx package
default[:sphinx][:yum_repo]     = 'yum::epel'

# tunable options
default[:sphinx][:use_stemmer]  = false
default[:sphinx][:use_mysql]    = false
default[:sphinx][:use_postgres] = false

default[:sphinx][:configure_flags] = [
  "--prefix=#{sphinx[:install_path]}",
  sphinx[:use_stemmer] ? '--with-libstemmer' : '--without-libstemmer',
  sphinx[:use_mysql] ? '--with-mysql' : '--without-mysql',
  sphinx[:use_postgres] ? '--with-pgsql' : '--without-pgsql'
]
default[:sphinx][:extra_configure_flags] = []

default[:sphinx][:searchd][:listen] = ["0.0.0.0:9312"]
default[:sphinx][:searchd][:log] = "/var/log/sphinx/sphinx.log"
default[:sphinx][:searchd][:query_log] = "/var/log/sphinx/query.log"
default[:sphinx][:searchd][:pid_file] = "/tmp/sphinx.pid"
default[:sphinx][:searchd][:read_timeout] = 5
default[:sphinx][:searchd][:max_children] = 30
default[:sphinx][:searchd][:max_matches] = 1000

default[:sphinx][:indexer][:mem_limit] = "32M"
default[:sphinx][:indexer][:write_buffer] = "1M"
default[:sphinx][:indexer][:max_file_field_buffer] = "8M"
