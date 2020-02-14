# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|

    # don't insert automatically generated keys on each host
    # instead, use the default "insecure" key, so the nodes can
    # communicate with the same ssh key
    config.ssh.insert_key = false

    # set default settings
    config.vm.box = "bento/centos-7"
    config.vm.provider "virtualbox" do |vb|
        vb.memory = 1024
        vb.cpus = 1
    end

    config.vm.define :ansible, primary: true do |machine|
        machine.vm.host_name = "ansible.local"
        machine.vm.network "private_network", ip: "192.168.50.10"

        machine.vm.provider "virtualbox" do |vb|
            vb.memory = 1024
            vb.cpus = 2
        end

        # install ansible
        machine.vm.provision "shell", path: "provision/install_ansible.sh"

        # sync ansible to /home/vagrant/ansible
        machine.vm.synced_folder "ansible/", "/home/vagrant/ansible"

        # upload vagrant private key to ansible controller
        machine.vm.provision "file", source: "~/.vagrant.d/insecure_private_key", destination: "$HOME/.ssh/id_rsa"
    end

    config.vm.define :node1 do |machine|
        machine.vm.host_name = "node1.local"
        machine.vm.network "private_network", ip: "192.168.50.12"
    end

    config.vm.define :node2 do |machine|
        machine.vm.host_name = "node2.local"
        machine.vm.network "private_network", ip: "192.168.50.13"
    end

    config.vm.define :node3 do |machine|
      machine.vm.host_name = "node3.local"
      machine.vm.network "private_network", ip: "192.168.50.14"
    end

    config.vm.define :awx, autostart: false do |machine|
        machine.vm.host_name = "awx.local"
        machine.vm.network "private_network", ip: "192.168.50.11"

        machine.vm.provider "virtualbox" do |vb|
            vb.memory = 4096
            vb.cpus = 2
        end

        # upload vagrant private key to awx
        machine.vm.provision "file", source: "~/.vagrant.d/insecure_private_key", destination: "$HOME/.ssh/id_rsa"
   
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

    config.vm.define :gitea, autostart: false do |machine|
        machine.vm.host_name = "gitea.local"
        machine.vm.network "private_network", ip: "192.168.50.15"

        machine.vm.provider "virtualbox" do |vb|
            vb.memory = 2048
            vb.cpus = 1
        end
   
        # install ansible and setup prerequisites for AWX
        machine.vm.provision "ansible_local", preserve_order: true do |ansible|
            ansible.playbook = "provision/install_gitea.yml"
            ansible.install_mode = :pip
            ansible.pip_install_cmd = "sudo yum install python3 python3-pip -y; sudo ln -s /usr/bin/pip3 /usr/bin/pip"
            ansible.compatibility_mode = "2.0"
        end
    end
end
