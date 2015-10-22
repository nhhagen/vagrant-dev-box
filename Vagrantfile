# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/trusty64"

    ports = [
        # 2304, # Deployd
        # 3306, # MySQL
        # 9200, # Elasticsearch
        # 9300, # Elasticsearch
        # 27017 # MongoDB
    ]

    config.vm.synced_folder "salt/roots/", "/srv/"
    config.vm.provision :salt do |salt|
        salt.minion_config = "salt/minion"
        salt.run_highstate = true
        salt.colorize = true
        salt.log_level = 'warning'
        salt.verbose = true
    end

    config.vm.define :dev, primary: true do |dev|
        dev.vm.hostname = 'develop'
        ports.each do |port|
            dev.vm.network :forwarded_port, guest: port, host: port
        end

        dev.vm.provider :virtualbox do |virtualbox|
            virtualbox.customize ["modifyvm", :id, "--cpus", "2"]
            virtualbox.customize ["modifyvm", :id, "--memory", "4096"]
            # virtualbox.customize ["modifyvm", :id, "--cpuexecutioncap", "90"]
        end
    end

    config.vm.define :azure, autostart: false do |azure|
        # azure.vm.synced_folder ".", "/vagrant", disabled: true

        azure.vm.provider :azure do |azure, override|
            # username = 'azureuser'
            password = '#########' # min 8 characters. should contain a lower case letter, an uppercase letter, a number and a special character

            override.vm.box = 'azure'
            override.vm.box_url = 'https://github.com/msopentech/vagrant-azure/raw/master/dummy.box'

            # override.ssh.username = username # assigned below
            override.ssh.password = password # assigned below

            azure.mgmt_certificate = '.azure/myCertPfx.pem'
            azure.mgmt_endpoint = 'https://management.core.windows.net'
            azure.subscription_id = '####################################'

            azure.vm_size = 'Medium'

            # Ubuntu Trusty 14.04 LTS
            azure.vm_image = 'b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-14_04-LTS-amd64-server-20140416.1-en-us-30GB'

            # azure.vm_user = username # defaults to 'vagrant' if not provided
            azure.vm_password = password # min 8 characters. should contain a lower case letter, an uppercase letter, a number and a special character

            azure.vm_name = '###############' # max 15 characters. contains letters, number and hyphens. can start with letters and can end with letters and numbers
            azure.cloud_service_name = '###############' # same as vm_name. leave blank to auto-generate
            azure.vm_location = 'North Europe' # e.g., West US

            azure.ssh_private_key_file = '.azure/myPrivateKey.key'
            azure.ssh_certificate_file = '.azure/myCertPfx.pem'

            # Provide the following values if creating a *Nix VM
            azure.ssh_port = '22'

            # Open TCP ports
            azure.tcp_endpoints = ports.join ','
        end
    end
end
