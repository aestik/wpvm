Vagrant.configure("2") do |config|
	config.vm.box = "chef/debian-7.4"
	config.vm.provider "virtualbox" do |vb|
		vb.customize ["modifyvm", :id, "--memory", "512"]
		vb.name = "coba-debian"
	end
	config.vm.network "private_network", ip: "12.12.12.2"
	config.vm.hostname = "coba-debian"
	config.vm.synced_folder "./www", "/var/www", owner: "www-data", group: "www-data"
	config.vm.synced_folder "./db", "/db"
	config.vm.provision "shell", path: "https://github.com/aestik/wpvm/raw/master/provisioner"
end
