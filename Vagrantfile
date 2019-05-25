# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  ansible_playbook = ENV['ANSIBLE_PLAYBOOK']
  ansible_group = ENV['ANSIBLE_GROUP']

  config.vm.define "docker" do |update|
    update.vm.box = "ubuntu/bionic64"
    update.vm.hostname ="docker"

  # VM Resources
  update.vm.provider "virtualbox" do |v|
     v.memory = 1024
     v.cpus   = 2
    end

    update.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/site.yml"

      ansible.groups = {
        "docker" => ["docker"],
      }
    end
  end
end