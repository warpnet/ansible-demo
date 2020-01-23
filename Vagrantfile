# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|

    config.vm.define :ansible, primary: true do |machine|
        machine.vm.box = "bento/centos-7"
        machine.vm.host_name = "ansible.local"
        machine.vm.network "private_network", ip: "192.168.50.10"

        machine.vm.provider "virtualbox" do |vb|
            vb.memory = 2048
            vb.cpus = 2
        end

        # install ansible
        machine.vm.provision "shell", path: "provision/install_ansible.sh"
    end

    config.vm.define :awx, autostart: false do |machine|
        machine.vm.box = "bento/centos-7"
        machine.vm.host_name = "awx.local"
        machine.vm.network "private_network", ip: "192.168.50.11"

        machine.vm.provider "virtualbox" do |vb|
            vb.memory = 4096
            vb.cpus = 2
        end

        # install ansible and setup prerequisites for AWX
        machine.vm.provision "ansible_local", preserve_order: true do |ansible|
            ansible.playbook = "provision/prerequisites_awx.yml"
            ansible.install_mode = :pip
            ansible.pip_install_cmd = "sudo yum install python3 python3-pip -y; sudo ln -s /usr/bin/pip3 /usr/bin/pip"
            ansible.compatibility_mode = "2.0"
        end

        # fix to reload new groups(docker)
        machine.vm.provision "shell", inline: "pkill -u vagrant sshd", preserve_order: true
        
        # install awx using the provided playbook
        machine.vm.provision "shell", path: "provision/install_awx.sh", privileged: false, preserve_order: true
    end
end