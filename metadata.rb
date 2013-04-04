name             "sphinx"
maintainer       "Jesse R. Adams"
maintainer_email "jesse@techno-geeks.org"
license          "Apache 2.0"
description      "Installs/Configures sphinx search engine."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.6.0"

recipe           "sphinx", "Installs sphinx"
recipe           "sphinx::package", "Installs sphinx from a package"
recipe           "sphinx::source", "Installs sphinx from source"

provides         "sphinx::default"
provides         "sphinx::package"
provides         "sphinx::source"

depends          "build-essential"
depends          "mysql"
depends          "postgresql"

supports         "centos"
supports         "rhel"
supports         "ubuntu"
supports         "debian"
