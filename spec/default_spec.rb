require 'spec_helper'

describe 'sphinx::default' do
  context 'installation method: package' do
    context 'platform: debian' do
      let(:chef_run) do
        runner = ChefSpec::Runner.new()
        runner.node.set['sphinx']['install_method'] = 'package'
        runner.node.set['platform_family'] = 'debian'
        runner.node.set['lsb']['codename'] = 'precise'
        runner.converge('sphinx::default')
      end

      it 'installs sphinx package' do
        expect(chef_run).to install_package 'sphinxsearch'
      end
    end

    context 'platform: redhat' do
      let(:chef_run) do
        runner = ChefSpec::Runner.new()
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
    context 'platform: debian' do
      context 'retrieve method: http' do
        context 'version: 2.0.8' do
          let(:chef_run) do
            runner = ChefSpec::Runner.new(:log_level => :debug)
            runner.node.set['sphinx']['version'] = '2.0.8'
            runner.node.set['platform_family'] = 'debian'
            runner.node.set['lsb']['codename'] = 'precise'
            runner.converge('sphinx::default')
          end

          it 'should create a sphinx config with the appropriate install_path' do
            regex = /Put files to be included in \/usr\/local\/conf.d/
            expect(chef_run).to render_file('/usr/local/sphinx.conf').with_content(regex)
          end
        end
      end
    end
  end
end
