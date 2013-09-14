# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "gello"

  config.vm.box_url = "http://domain.com/path/to/above.box"

  config.vm.network :forwarded_port, guest: 5432, host: 5432 # "postgres"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "dev/chef/cookbooks"
    chef.roles_path = "dev/chef/roles"
    chef.add_role "db"
    chef.json = {
      :postgresql => {
        :listen_addresses => "*",
        :version => "9.1",
        :password => {:postgres => 'password'}
      }    
    }
  end
end
