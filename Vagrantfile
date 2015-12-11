# -*- mode: ruby -*-
# vim: set ft=ruby expandtab ts=4 sw=4:

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.define :linux do |lin_config|
        lin_config.vm.box = "ubuntu/trusty64"

        lin_config.berkshelf.enabled = true
        lin_config.berkshelf.berksfile_path = 'Berksfile'

        lin_config.vm.network :private_network, :ip => '10.10.10.10'
        lin_config.vm.network :forwarded_port, guest: 5858, host: 5858, id: "admin_node_debug", auto_correct: true
        lin_config.vm.synced_folder "codebase/", "/codebase",
            create: true, owner: "vagrant", group: "vagrant"

        lin_config.vm.provider "virtualbox" do |v|
            v.memory = 1024
            v.name = 'angular_conf_linux'

            v.customize ['modifyvm', :id, '--cpuexecutioncap', '100']
            v.customize ['modifyvm', :id, '--cpuhotplug', 'on']
            v.customize ['modifyvm', :id, '--cpus', 2]
        end

        lin_config.vm.provision :chef_solo do |chef|
            # Use 'doc' for very verbose output. Use 'min' for rspec style dots and letters.
            #chef.arguments = '-F doc'
            chef.log_level = :debug

            chef.add_recipe 'linux_base'
        end
    end
end
