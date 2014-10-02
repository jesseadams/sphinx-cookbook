Sphinx cookbook
===

[![Travis CI](https://travis-ci.org/jesseadams/sphinx-cookbook.png)](https://travis-ci.org/jesseadams/sphinx-cookbook)

Description
---

Installs and configures Sphinx search (searchd). Installation can by from source (http or svn)  or package. Also it contains lwrp for creating index sources and indexes.

Requirements
---
### Cookbooks
- build-essential
- mysql
- postgresql
- yum
- yum-epel
- apt
- tar

### Platforms
The following platforms are supported and tested under test kitchen:

- CentOS 6.5
- Ubutu 14.04

Also it should work on RedHat 6 and Debian 7.

Attributes
---

Thanks to several contributions this cookbook has a lot of flexibility. See attributes/default.rb for a full list of attributes and capabilities.

Recipes
---
- default.rb - Installs sphinx
- package.rb - Installs sphinx from a package
- source.rb - Installs sphinx from source
- rpm.rb - Installs sphinx from rpm

LWRP
---
- sphinx_sql_source - creates source for sphinx index, which allows index sql databases.
- sphinx_pipe_source - creates source for sphinx index, which get data from pipe command.
- sphinx_index - creates index.
- sphinx_reindex - allows reindex index. It takes following parameters:
    - name - sphinx index name. Name attribute.
    - rotate -  should reindex send HUP to searchd or not. Default: true.

Source and index LWRP have attributes that match with sphinx configuration parameters. For details see resource definition files.
If your version of sphinx has parameter, what is not in the lwrp attributes, you have  two way:

- Add it to lwrp and make pull-request
- Create you own template in node[:sphinx][:conf_path]/conf.d directory and reindex index.


## Usage Examples

### Source Install From HTTP

Install version 2.0.8 from source.

```ruby
name "sphinx"
description "Sphinx search daemon (searchd)"

# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "role[base]",
  "recipe[sphinx]",
)

# Attributes applied if the node doesn't have it set already.
default_attributes({
  'sphinx' => {
    'use_mysql'   => true,
    'install_method' => 'source',
    'source' => {
    	'source_url' => 'http://sphinxsearch.com/files/sphinx-2.2.4-release.tar.gz'
    }
  }
})

# Attributes applied no matter what the node has set already.
#override_attributes()
```

### Source Install From SVN

By default, this will grab HEAD from trunk.

```ruby
name "sphinx"
description "Sphinx search daemon (searchd)"

# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "role[base]",
  "recipe[sphinx]",
)

# Attributes applied if the node doesn't have it set already.
default_attributes({
  'sphinx' => {
    'use_mysql'   => true,
    'install_method' => 'source',
    'retrieve_method' => 'svn'
  }
})

# Attributes applied no matter what the node has set already.
#override_attributes()
```

### Package Install + MySQL Support

Here is an example role using MySQL with a package install, using the latest packages.

```ruby
name "sphinx"
description "Sphinx search daemon (searchd)"

# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "role[base]",
  "recipe[sphinx]",
)

# Attributes applied if the node doesn't have it set already.
default_attributes({
  'sphinx' => {
    'use_mysql'   => true,
    'install_method' => 'package'
  }
})

# Attributes applied no matter what the node has set already.
#override_attributes()
```

Recipes only install searchd daemon and enable it. searchd didn't work if in it's config missing information about indexes. So you must create indexes via lwrp in your wrapper cookbook.

## History

See [CHANGELOG.md](https://github.com/jesseadams/sphinx-cookbook/blob/master/CHANGELOG.md)

## Maintainers

* [@jesseadams](https://github.com/jesseadams)
* [@kesor](https://github.com/kesor)
