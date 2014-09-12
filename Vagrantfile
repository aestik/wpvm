require 'yaml'
dir = File.dirname(File.expand_path(__FILE__))
data = YAML.load_file("#{dir}/host.yaml")

Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/trusty64"
	config.vm.provider "virtualbox" do |vb|
		vb.customize ["modifyvm", :id, "--memory", data['memory'] ]
		vb.name = data['hostname']
	end
	config.vm.network "private_network", ip: data['ipaddress']
	config.vm.hostname = data['hostname']
	config.vm.synced_folder "./www", "/var/www", owner: "www-data", group: "www-data"
	config.vm.synced_folder "./db", "/db"
	config.vm.provision "shell", path: "https://github.com/aestik/wpvm/raw/master/provisioner"
end
