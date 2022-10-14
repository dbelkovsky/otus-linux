# -*- mode: ruby -*-
# vim: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.vm.box_check_update = true

  config.vm.define "server.test.local" do |s|
    s.vm.hostname = 'server.test.local'
    s.vm.network "private_network", ip: "192.168.50.10"
	s.vm.provider :virtualbox do |v|
		v.name = "server.test.local"
		v.customize ["modifyvm", :id, "--cpus", 4, "--memory", "2048"]
    end

	s.vm.provision "ansible" do |ansible|
        ansible.playbook = "server.yml"
	end
	
  end
  
  config.vm.define "client1.test.local", primary: true do |c|
    c.vm.hostname = 'client1.test.local'
    c.vm.network "private_network", ip: "192.168.50.11"
	c.vm.provider :virtualbox do |v|
		v.name = "client1.test.local"
		v.customize ["modifyvm", :id, "--cpus", 2, "--memory", "256"]

    end

	c.vm.provision "ansible" do |ansible|
        ansible.playbook = "client1.yml"
	end
	
  end

  
end
