require File.expand_path('../support/helpers', __FILE__)

describe "sphinx_test::default" do
  include Helpers::SphinxTest

  it 'installed searchd' do
    case node[:sphinx][:install_method]
    when 'package'
      file('/usr/bin/searchd').must_exist
    when 'source'
      file('/usr/local/bin/searchd').must_exist
    end
  end

  it 'installed the correct version' do
    if node[:sphinx][:install_method] == 'source'
      `/usr/local/bin/searchd -h | head -1 | grep -q \"#{node[:sphinx][:version]}[^\.]\"`
      $?.to_i.must_equal 0
    end
  end
end
