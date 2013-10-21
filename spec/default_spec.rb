require 'spec_helper'

describe 'sphinx::default' do
  context 'installation method: package' do
    context 'platform: debian' do
      let(:chef_run) do
        runner = ChefSpec::ChefRunner.new()
        runner.node.set['sphinx']['install_method'] = 'package'
        runner.node.set['platform_family'] = 'debian'
        runner.converge('sphinx::default')
      end

      it 'installs sphinx package' do
        expect(chef_run).to install_package 'sphinxsearch'
      end
    end

    context 'platform: redhat' do
      let(:chef_run) do
        runner = ChefSpec::ChefRunner.new()
        runner.node.set['sphinx']['install_method'] = 'package'
        runner.node.set['platform_family'] = 'redhat'
        runner.converge('sphinx::default')
      end

      it 'installs sphinx package' do
        expect(chef_run).to install_package 'sphinx'
      end
    end
  end

  context 'installation method: source' do
    context 'retrieve method: http' do
      context 'version: 2.0.8' do
        let(:chef_run) do
          runner = ChefSpec::ChefRunner.new(:log_level => :debug)
          runner.node.set['sphinx']['version'] = '2.0.8'
          runner.converge('sphinx::default')
        end

#        it 'should create a remote file ' do
#          expect(chef_run).to create_remote_file('/tmp/sphinx-2.0.8-release.tar.gz')
#          expect(runner).to create_remote_file_if_missing('sphinx-2.0.8-release.tar.gz').with(
#            :source => 'http://sphinxsearch.com/files/sphinx-2.0.8-release.tar.gz'
#          )
#        end
      end
    end
  end
end
