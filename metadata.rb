maintainer       "Alex Soto"
maintainer_email "apsoto@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures sphinx search engine."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.5"

depends "build-essential"

recipe "sphinx", "Installs sphinx"
recipe "sphinx::package", "Installs sphinx from a package"
recipe "sphinx::source", "Installs sphinx from source"
