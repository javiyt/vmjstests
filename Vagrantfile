# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.network :forwarded_port, guest: 9876, host: 9876
  config.vm.network :forwarded_port, guest: 9878, host: 9878
  config.vm.network :forwarded_port, guest: 8080, host: 8080

    config.vm.hostname = "jstests.vm"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
  end
end
