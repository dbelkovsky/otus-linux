# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end
  config.vm.define "master" do |master|
    master.vm.network "private_network", ip: "192.168.1.10", virtualbox__intnet: "local"
    master.vm.hostname = "master"
  end
  config.vm.define "slave" do |slave|
    slave.vm.network "private_network", ip: "192.168.1.20", virtualbox__intnet: "local"
    slave.vm.hostname = "slave"
  end
  config.vm.define "backup" do |backup|
    backup.vm.network "private_network", ip: "192.168.1.30", virtualbox__intnet: "local"
    backup.vm.hostname = "backup"
  end


  config.vm.provision "ansible" do |ansible|
    #ansible.verbose = "vvv"
    ansible.playbook = "provisioning/playbook.yml"
    ansible.become = "true"
  end

end
