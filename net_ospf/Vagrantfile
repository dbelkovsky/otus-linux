# -*- mode: ruby -*-
# vim: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.vm.box_check_update = true
 #config.vbguest.auto_update = false
    
	
  config.vm.define "r1" do |r1|
    r1.vm.hostname = 'r1'
	r1.vm.network "private_network", ip: "172.20.10.1", netmask: "255.255.255.0" , adapter: 2,  virtualbox__intnet: "r1"
    r1.vm.network "private_network", ip: "192.168.0.1", netmask: "255.255.255.252" , adapter: 3,  virtualbox__intnet: "r1r2"
	r1.vm.network "private_network", ip: "192.168.200.1", netmask: "255.255.255.252" , adapter: 4,  virtualbox__intnet: "r1r3"
	r1.vm.provider :virtualbox do |v|
		v.name = "r1"
    end

	r1.vm.provision "ansible" do |ansible|
        ansible.playbook = "r1.yml"
	end
	
  end
  
  config.vm.define "r2", primary: true do |r2|
    r2.vm.hostname = 'r2'
	r2.vm.network "private_network", ip: "172.20.20.1", netmask: "255.255.255.0" , adapter: 2,  virtualbox__intnet: "r2"
    r2.vm.network "private_network", ip: "192.168.0.2", netmask: "255.255.255.252" , adapter: 3,  virtualbox__intnet: "r1r2"
	r2.vm.network "private_network", ip: "192.168.100.2", netmask: "255.255.255.252" , adapter: 4,  virtualbox__intnet: "r2r3"
	r2.vm.provider :virtualbox do |v|
		v.name = "r2"

    end

	r2.vm.provision "ansible" do |ansible|
        ansible.playbook = "r2.yml"
	end
	
  end

  config.vm.define "r3" do |r3|
    r3.vm.hostname = 'r3'
	r3.vm.network "private_network", ip: "172.20.30.1", netmask: "255.255.255.0" , adapter: 2,  virtualbox__intnet: "r3"
    r3.vm.network "private_network", ip: "192.168.200.2", netmask: "255.255.255.252" , adapter: 3,  virtualbox__intnet: "r1r3"
	r3.vm.network "private_network", ip: "192.168.100.1", netmask: "255.255.255.252" , adapter: 4,  virtualbox__intnet: "r2r3"
	r3.vm.provider :virtualbox do |v|
		v.name = "r3"
    end

	r3.vm.provision "ansible" do |ansible|
        ansible.playbook = "r3.yml"
	end
	
  end
  
end

