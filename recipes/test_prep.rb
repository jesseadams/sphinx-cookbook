case node[:platform_family]
when 'debian'
  file '/var/lib/apt/periodic/update-success-stamp' do
    action :delete
  end

  include_recipe "apt"

  execute "apt-get-upgrade" do
    command 'DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade'
    action :run
  end
end
