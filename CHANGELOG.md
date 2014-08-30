1.1.0

* Tons of housekeeping from (thanks [@devx](https://github.com/devx))
* Upgraded rspec and chefspec and fixed tests

1.0.3

* Loosened dependencies on other cookbooks (thanks for assistance [@chris-at-thewebfellas](https://github.com/chris-at-thewebfellas))
* Fixed regression with stemmer

1.0.1/1.0.2

* Fixed install_path for source installations (thanks [@balbeko](https://github.com/balbeko))
* Upgraded to ChefSpec 3

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
