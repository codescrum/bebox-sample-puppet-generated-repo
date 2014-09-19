# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	
	  config.vm.define :'node1.server1.test' do |node|
	    node.vm.box = "bebox-sample-puppet-generated-repo-node1.server1.test"
	    node.vm.hostname = "node1.server1.test"
	    node.vm.network :public_network, :bridge => 'en0: Ethernet', :auto_config => false
	    node.vm.provision :shell, :inline => "sudo ifconfig eth1 192.168.0.81 netmask 255.255.255.0 up"
	  end
	  config.vm.provider "virtualbox" do |v|
	  	v.memory = 512
	  	v.cpus = 1
	  	v.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
	  end
	
end