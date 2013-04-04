#### Description ####

Installs and configures Sphinx search (searchd). Installation can by from source or package.

#### Requirements #####

This cookbook depends on the mysql and postgresql cookbooks.

#### Attributes ####

See attributes/default.rb for a full list.

#### Usage ####

##### MySQL #####

Here is an example role using MySQL with a package install

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
    'use_package' => true
  }
})

# Attributes applied no matter what the node has set already.
#override_attributes()
```

#### History ####

0.5.0

* Added package install option

0.4.0

* Updated Download URL for sphinx source
