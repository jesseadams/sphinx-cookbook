require 'spec_helper'

describe 'sphinx::default' do
  context 'installation method: package' do
    context 'platform: debian' do
      let(:chef_run) do
        runner = ChefSpec::Runner.new(platform: 'debian', version: '7.5')
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

  context 'platform: debian' do
    context 'installation method: source' do
      context 'retrieve method: http' do
        context 'version: 2.0.8' do
          let(:chef_run) do
            runner = ChefSpec::Runner.new(platform: 'debian', version: '7.5')
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

    context 'installation method: deb' do
      context 'version: 2.1.9' do
        let(:chef_run) do
          runner = ChefSpec::Runner.new(platform: 'debian', version: '7.5')
          runner.node.set['sphinx']['version'] = '2.1.9'
          runner.node.set['sphinx']['install_method'] = 'deb'
          runner.node.set['platform_family'] = 'debian'
          runner.node.set['lsb']['codename'] = 'wheezy'
          runner.converge('sphinx::default')
        end
        let(:deb_filename) { 'sphinxsearch_2.1.9-release-1~wheezy_amd64.deb' }
        let(:local_package) do
          File.join("#{Chef::Config[:file_cache_path]}", deb_filename)
        end
        let(:base_conf_dir) { '/etc/sphinxsearch' }
        let(:base_var_dir) { '/var/lib/sphinxsearch' }

        it 'overrides daemon autostart' do
          conf_file = '/etc/default/sphinxsearch'
          expect(chef_run).to render_file(conf_file).
            with_content('START=no')
          expect(chef_run).to create_file(conf_file).
            with(user: 'root', group: 'root', mode: 0644)
        end


        it 'retrieves remote_file from repo' do
          url = "http://sphinxsearch.com/files/#{deb_filename}"
          expect(chef_run).to create_remote_file_if_missing(local_package).
            with(source: url)
        end

        it 'install debian package from repo' do
          expect(chef_run).to install_dpkg_package(deb_filename).
            with(source: local_package, options: '--force-confold')
        end

        it 'creates conf.d directory' do
          expect(chef_run).to create_directory("#{base_conf_dir}/conf.d")
        end

        it 'creates data directory' do
          expect(chef_run).to create_directory("#{base_var_dir}/data")
        end

        it 'creates sphinx.conf' do
          regex = /Put files to be included in #{base_conf_dir}\/conf.d/
          expect(chef_run).to render_file("#{base_conf_dir}/sphinx.conf")
            .with_content(regex)
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
        runner.node.set['sphinx']['repo']['base_url'] = 'http://sphinxsearch.com/files/'
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
