require 'spec_helper'

describe 'sphinx::default' do
  context 'installation method: package' do
    context 'platform: debian' do
      let(:chef_run) do
        runner = ChefSpec::ChefRunner.new()
        runner.node.set['sphinx']['use_package'] = true
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
        runner.node.set['sphinx']['use_package'] = true
        runner.node.set['platform_family'] = 'redhat'
        runner.converge('sphinx::default')
      end

      it 'installs sphinx package' do
        expect(chef_run).to install_package 'sphinx'
      end
    end
  end
end
