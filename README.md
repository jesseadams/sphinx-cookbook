[![Travis CI](https://travis-ci.org/jesseadams/sphinx-cookbook.png)](https://travis-ci.org/jesseadams/sphinx-cookbook)

## Description

Installs and configures Sphinx search (searchd). Installation can by from source (http or svn)  or package.

## Attributes

Thanks to several contributions this cookbook has a lot of flexibility. See attributes/default.rb for a full list of attributes and capabilities.

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
    'version' => '2.0.8'
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

### Debian upstream package install

Here is an example role using MySQL with a package install, using the latest packages.

```ruby
name "sphinx"
description "Sphinx search daemon (searchd)"

run_list(
  "role[base]",
  "recipe[sphinx]",
)

default_attributes({
  'sphinx' => {
    'version' => '2.1.9',
    'install_method' => 'deb'
  }
})
```

If you want to override Debian package name ( if you are using squeeze ), you can set the debian package name as follows:

```ruby
default_attributes({
  'sphinx' => {
    'install_method' => 'deb',
    'version' => '2.1.9',
    'deb' => {
      'name' => 'sphinxsearch_2.1.9-release-1_amd64.deb'
    }
  }
})
```

## History

See [CHANGELOG.md](https://github.com/jesseadams/sphinx-cookbook/blob/master/CHANGELOG.md)

## Maintainers

* [@jesseadams](https://github.com/jesseadams)
* [@kesor](https://github.com/kesor)
