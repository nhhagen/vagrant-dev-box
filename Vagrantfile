# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/trusty64"

    # Port forwarding
    # Deployd
    # config.vm.network :forwarded_port, guest: 2304, host: 2304
    #
    # Elasticsearch
    # config.vm.network :forwarded_port, guest: 9200, host: 9200
    # config.vm.network :forwarded_port, guest: 9300, host: 9300
    #
    # MySQL
    # config.vm.network :forwarded_port, guest: 3306, host: 3306
    #
    # MongoDB
    # config.vm.network :forwarded_port, guest: 27017, host: 27017

    config.vm.synced_folder "salt/roots/", "/srv/"
    config.vm.provision :salt do |salt|
        salt.minion_config = "salt/minion"
        salt.run_highstate = true
        salt.verbose = true
    end

    # Add more CPU cores and RAM to virtualbox
    config.vm.provider "virtualbox" do |virtualbox|
        virtualbox.customize ["modifyvm", :id, "--cpus", "2"]
        virtualbox.customize ["modifyvm", :id, "--memory", "4096"]
    end
end
