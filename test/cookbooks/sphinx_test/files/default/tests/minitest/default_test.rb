require File.expand_path('../support/helpers', __FILE__)

describe "sphinx_test::default" do
  include Helpers::SphinxTest

  it 'installed searchd' do
    file('/usr/bin/searchd').must_exist
  end

  it 'installed the correct version' do
    if node[:sphinx][:use_package] == false
      `/usr/bin/searchd -h | head -1 | grep -q \"#{node[:sphinx][:version]}[^\.]\"`
      $?.to_i.must_equal 0
    end
  end
end
