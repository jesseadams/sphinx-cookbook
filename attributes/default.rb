default[:sphinx][:use_package]  = false
default[:sphinx][:install_path] = "/opt/sphinx"
default[:sphinx][:version]      = '2.0.4'
default[:sphinx][:url]          = "http://sphinxsearch.com/files/sphinx-#{sphinx[:version]}-release.tar.gz"
default[:sphinx][:stemmer_url]  = "http://snowball.tartarus.org/dist/libstemmer_c.tgz"
default[:sphinx][:user]         = 'root'
default[:sphinx][:group]        = 'root'

# tunable options
default[:sphinx][:use_stemmer]  = false
default[:sphinx][:use_mysql]    = false
default[:sphinx][:use_postgres] = false

default[:sphinx][:configure_flags] = [
  "#{sphinx[:use_stemmer] ? '--with-stemmer' : '--without-stemmer'}",
  "#{sphinx[:use_mysql] ? '--with-mysql' : '--without-mysql'}",
  "#{sphinx[:use_postgres] ? '--with-pgsql' : '--without-pgsql'}"
]


