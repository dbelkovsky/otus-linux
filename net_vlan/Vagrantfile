# -*- mode: ruby -*-
# vim: set ft=ruby :


MACHINES = {
  :inetRouter => {
        :box_name => "centos/7",
        :net => [
                   {adapter: 2, auto_config: false, virtualbox__intnet: "inetRouter"},
                   {adapter: 3, auto_config: false, virtualbox__intnet: "inetRouter"},
                ]
  },
  :centralRouter => {
        :box_name => "centos/7",
        :net => [
                   {adapter: 2, auto_config: false, virtualbox__intnet: "inetRouter"},
                   {adapter: 3, auto_config: false, virtualbox__intnet: "inetRouter"},
	                 {adapter: 4, auto_config: false, virtualbox__intnet: "router-subnet"},
	                 {adapter: 5, auto_config: false, virtualbox__intnet: "router-subnet"}
                ]
  },
  
  :testRouter1 => {
        :box_name => "centos/7",
        :net => [
				           {adapter: 2, auto_config: false, virtualbox__intnet: "router-subnet"},
                   {adapter: 3, auto_config: false, virtualbox__intnet: "test-subnet-vlan100"}
                ]
  },

  :testRouter2 => {
        :box_name => "centos/7",
        :net => [
				           {adapter: 2, auto_config: false, virtualbox__intnet: "router-subnet"},
                   {adapter: 3, auto_config: false, virtualbox__intnet: "test-subnet-vlan200"}
                ]
  },

  :testClient1 => {
        :box_name => "centos/7",
        :net => [
                   {adapter: 2, auto_config: false, virtualbox__intnet: "test-subnet-vlan100"}
                ]
  },
  
  :testServer1 => {
        :box_name => "centos/7",
        :net => [
                   {adapter: 2, auto_config: false, virtualbox__intnet: "test-subnet-vlan100"}
                ]
  },

  :testClient2 => {
        :box_name => "centos/7",
        :net => [
                   {adapter: 2, auto_config: false, virtualbox__intnet: "test-subnet-vlan200"}
                ]
  },
  
  :testServer2 => {
        :box_name => "centos/7",
        :net => [
                   {adapter: 2, auto_config: false, virtualbox__intnet: "test-subnet-vlan200"}
                ]
  },
}

Vagrant.configure("2") do |config|
  
  MACHINES.each do |boxname, boxconfig|

    config.vm.define boxname do |box|

        box.vm.box = boxconfig[:box_name]
        box.vm.host_name = boxname.to_s

        boxconfig[:net].each do |ipconf|
          box.vm.network "private_network", ipconf
        end
        
        if boxconfig.key?(:public)
          box.vm.network "public_network", boxconfig[:public]
        end

        box.vm.provision "shell", inline: <<-SHELL
          mkdir -p ~root/.ssh
                cp ~vagrant/.ssh/auth* ~root/.ssh
        SHELL
        
        case boxname.to_s
          when "inetRouter"
            box.vm.provision "ansible" do |ansible|
            ansible.playbook = "inetRouter.yml"
          end
		  when "centralRouter"
            box.vm.provision "ansible" do |ansible|
            ansible.playbook = "centralRouter.yml"
          end
		  when "testRouter1"
            box.vm.provision "ansible" do |ansible|
            ansible.playbook = "testRouter1.yml"
          end
		  when "testRouter2"
            box.vm.provision "ansible" do |ansible|
            ansible.playbook = "testRouter2.yml"
          end
		  when "testClient1"
            box.vm.provision "ansible" do |ansible|
            ansible.playbook = "testClient1.yml"
          end
		  when "testServer1"
            box.vm.provision "ansible" do |ansible|
            ansible.playbook = "testServer1.yml"
          end
		  when "testClient2"
            box.vm.provision "ansible" do |ansible|
            ansible.playbook = "testClient2.yml"
          end
		  when "testServer2"
            box.vm.provision "ansible" do |ansible|
            ansible.playbook = "testServer2.yml"
          end
		end
      end

  end
  
  
end

