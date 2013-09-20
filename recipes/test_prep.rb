case node[:platform_family]
when 'debian'
  execute "apt-get-update" do
    command "apt-get update"
    action :run
  end

  execute "apt-get-upgrade" do
    command 'DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade'
    action :run
  end
end
