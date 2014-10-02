require 'spec_helper'

describe 'sphinx::default' do
  context 'installation method: package' do
    context 'platform: debian' do
      let(:chef_run) do
        runner = ChefSpec::Runner.new(platform: 'debian', version: '7.6')
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
        runner = ChefSpec::Runner.new(platform: 'redhat', version: '6.4')
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
            runner = ChefSpec::Runner.new(platform: 'debian', version: '7.6')
            runner.node.set['sphinx']['version'] = '2.0.8'
            runner.node.set['platform_family'] = 'debian'
            runner.node.set['lsb']['codename'] = 'precise'
            runner.converge('sphinx::default')
          end

          it 'should create a sphinx config with the appropriate install_path' do
            regex = /Put files to be included in \/opt\/sphinx\/etc/
            expect(chef_run).to render_file('/opt/sphinx/etc/sphinx.conf').with_content(regex)
          end
        end
      end
    end
  end

  context 'installation method: rpm' do
    context 'platform: redhat' do
      let(:chef_run) do
        runner = ChefSpec::Runner.new(platform: 'redhat', version: '6.4')
        runner.node.set['sphinx']['install_method'] = 'rpm'
        runner.node.set['sphinx']['rpm']['name'] = 'sphinx-2.2.3-1.rhel6.x86_64.rpm'
        runner.node.set['sphinx']['rpm']['base_url'] = 'http://sphinxsearch.com/files/'
        runner.node.set['platform_family'] = 'redhat'
        runner.converge('sphinx::default')
      end

      it 'installs sphinx package via rpm' do
        regex = /Put files to be included in \/etc\/sphinx\/conf.d/
        expect(chef_run).to render_file('/etc/sphinx/sphinx.conf').with_content(regex)
      end
    end
  end

end
