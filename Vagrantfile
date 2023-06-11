# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    config.vm.box = "bento/ubuntu-22.04" # 22.04 LTS, Jammy
  
    config.vm.define "master" do |master|
      master.vm.hostname = "master"
      master.vm.network :private_network, ip: "192.168.69.2"

      master.vm.provider "virtualbox" do |pmv|
        pmv.memory = 2048
      end
    end
  
    config.vm.define "worker" do |worker|
      worker.vm.hostname = "worker"
      worker.vm.network :private_network, ip: "192.168.69.3"
    end
  
    # Increase memory for Libvirt
    config.vm.provider "libvirt" do |libvirt|
      libvirt.memory = 1024
    end
    
    # Increase memory for Virtualbox
    config.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
    end
  end
  