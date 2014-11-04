# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  #config.vm.box = "hashicorp/precise64"
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision :shell, :inline => "echo \"Europe/Berlin\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"

  config.vm.define :jenkins do |jenkins|
    jenkins.vm.hostname = "jenkins"
    
    jenkins.vm.network :forwarded_port, guest:8888, host: 8888
    jenkins.vm.network :private_network, ip: "192.168.25.2"
    
    jenkins.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 4
    end

    jenkins.vm.provision :ansible do |ansible|
      ansible.playbook = "ansible/common.yml"
    end
   
  end

  config.vm.define :nexus do |nexus|
    nexus.vm.hostname = "nexus"
    
    nexus.vm.network :forwarded_port, guest:8081, host: 8081
    nexus.vm.network :private_network, ip: "192.168.25.3"

    nexus.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 4
    end
    
    #nexus.vm.provision :ansible do |ansible|
    #  ansible.playbook = "ansible/common.yml"
    #end
    nexus.vm.provision :puppet, :module_path => "modules" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file = "nexus.pp"
    end
  end

  config.vm.define :stash do |stash|
    stash.vm.hostname = "stash"

    stash.vm.provider "virtualbox" do |v|
      v.memory = 2096
      v.cpus = 4
    end
    
    stash.vm.network :forwarded_port, guest: 7990, host: 7990
    stash.vm.network :private_network, ip: "192.168.25.40";
    

    stash.vm.provision :puppet, :module_path => "modules" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "default.pp"
    end
  end
end