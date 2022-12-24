# -*- mode: ruby -*-
# vim: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "centos/8"
  config.vm.box_check_update = true
  #config.vbguest.auto_update = false
	
	

  
  config.vm.define "web", primary: true do |w|
    w.vm.hostname = 'web'
    w.vm.network "private_network", ip: "192.168.100.20"
	w.vm.provider :virtualbox do |v|
		v.name = "web"
		v.customize ["modifyvm", :id, "--cpus", 4, "--memory", "2048"]

    end

	w.vm.provision "ansible" do |ansible|
        ansible.playbook = "web.yml"
		#ansible.verbose = "vvv"
	end
	
  end


  
end

