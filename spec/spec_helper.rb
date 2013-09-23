require 'chefspec'
require 'berkshelf'

RSpec.configure do |config|
  config.color_enabled = true
  config.tty = true
  config.formatter = :documentation
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

berksfile = Berkshelf::Berksfile.from_file('Berksfile')
berksfile.install(path: 'vendor/cookbooks')
