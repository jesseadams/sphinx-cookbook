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
    'version => '2.0.8'
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

## History

1.0.0

* Major overhaul to how sphinx gets installed
* Added ability to install from source retrieved from SVN (thanks for idea [@goruha](https://github.com/goruha))

0.6.7

* Added test-kitchen, chefspec, and basic tests

0.6.6

* Fix for variable naming mismatch introduced in 0.6.4 (thanks [@thewebfellas](https://github.com/thewebfellas))

0.6.5

* Percona server support (thanks [@antono](https://github.com/antono))

0.6.4

* Better handling of custom bindir when building from source (thanks [@justinlocsei](https://github.com/justinlocsei))

0.6.3

* Older and non-release versions of sphinx can now be built from source (thanks [@justinlocsei](https://github.com/justinlocsei))
* Added ability to cleanly add additional configure flags (thanks [@justinlocsei](https://github.com/justinlocsei))

0.6.2

* Resolved several items identified by foodcritic
* Fixed configuration flag for libstemmer (thanks [@seanculver](https://github.com/seanculver))

0.6.1

* Use install_path attribute as the --prefix for source installation
* Download files to the proper file_cache_path instead of /tmp
* Dynamically determine package_name based on platform, with manual override

0.6.0

* Made package version force attribute optional
* Added several required fields to metadata
* Rebuilt metadata.json
* Added recipe lines to metadata for OpsWorks (thanks [@ryansch](https://github.com/ryansch))
* Added lwrp for indexes and sources, searchd and indexer configs from attributes (thanks [@makmanalp](https://github.com/makmanalp))

0.5.0

* Added package install option (thanks [@RiotGames](https://github.com/RiotGames))

0.4.0

* Updated Download URL for sphinx source (thanks [@RiotGames](https://github.com/RiotGames))

## Maintainers

* [@jesseadams](https://github.com/jesseadams)
* [@kesor](https://github.com/kesor)
