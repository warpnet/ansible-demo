# Vagrant Demo
This Vagrant setup installs 3 CentOS 7 machines, 1 ansible controller and 2 nodes that can be managed by Ansible. Also this Vagrant setup provides a development AWX machine, so you can test and develop environments using Anisible AWX. 

This setup can be used to develop Ansible playbooks and AWX or can be used for workshops and other educational purposes.

## Prerequisites
This setup has been tested on Ubuntu 18.04 LTS and MacOS Catalina. The following prerequisites are needed:
- Vagrant 2.2.6
- virtualbox 6.0 (virtualbox 6.1 is currently not supported by Vagrant)
- virtualbox extension pack (https://download.virtualbox.org/virtualbox/6.0.14/Oracle_VM_VirtualBox_Extension_Pack-6.0.14.vbox-extpack)

### Libvirt instead of VirtualBox

It is also possible to use Libvirt/Qemu instead of VirtualBox. This requires:
- vagrant
- libvirt

Install Vagrant:

```bash
apt install -y vagrant
```

Then, use `Vagrantfile-libvirt` instead of `Vagrantfile`:

```bash
mv Vagrantfile Vagrantfile-virtualbox
cp Vagrantfile-libvirt Vagrantfile
```

## How to use
After you installed the prerequisites you can start using the environment by following the steps underneath. If you want to jump straight into AWX click [here](#AWX).

```bash
git clone https://github.com/warpnet/ansible-demo.git
cd ansible-demo
vagrant up
```

After vagrant up has setup the environment you can start developing your playbooks in the ansible directory. There is no need to develop in the virtual machines that Vagrant just created. The ansible directory is synced to the ansible machine (`/home/vagrant/ansible`). So you can use your favorite editor on your local machine!

In order to execute your newly developed playbook, you need to ssh into the vagrant machine and navigate to the correct folder.

```bash
user@laptop:~/ansible-demo$ vagrant ssh ansible

[vagrant@ansible ~]$ cd ansible
[vagrant@ansible ~]$ ansible-playbook my_first_playbook.yml
```

| NOTE: All Vagrant commands need to be executed from the root of the ansible-demo directory, where the `Vagrantfile` is. |
| --- |

### SSH
Vagrant will insert the default "insecure" key to the machines Ansible and AWX machine. Using this method, those two machines can login via ssh on the nodes to execute actions.

The private key is located in the home folder of the vagrant user (`/home/vagrant/.ssh/id_rsa`). This key can be used to login over ssh on the machines. Make sure that ansible is being executed as the `vagrant` user.

## AWX
If you want to test out Ansible AWX you will need to explicity tell Vagrant to start the AWX machine. Make sure you have at least 4GB of memory free on your local machine in order to start AWX. The provisioning of AWX will take 5-15 minutes depending on your hardware and internet connection.

```bash
vagrant up awx
```

After the provisioning is done you will be provided with the information to access AWX. You can access AWX using your web browser on your local machine using the information provided.

```
[...]
awx: =======================================================================
awx: Provisioning of Ansible AWX completed!
awx: You can access Ansible AWX via your web browser on your local machine:
awx: 
awx: url:      http://192.168.50.11
awx: username: admin
awx: password: password
awx: =======================================================================
```

To SSH into the machine:

```bash
vagrant ssh awx
```

## Overview
This section provides additional information of the Vagrant setup

### Overview
This table shows the machine names, hostnames and ip addresses. You can use the ip addresses in you Ansible inventory file. The hostnames are not resolvable by default.

Vagrant name | Hostname | IP Address
--- | --- | ---
ansible | ansible.local | 192.168.50.10
awx | awx.local | 192.168.50.11
node1 | node1.local | 192.168.50.12
node2 | node2.local | 192.168.50.13

### Vagrant SSH
To ssh into one of the three vagrant boxes you can use the vagrant ssh command. First checkout which names the virtual machines have.

```bash
user@laptop:~/ansible-demo$ vagrant status
Current machine states:

ansible                   running (virtualbox)
node1                     running (virtualbox)
node2                     running (virtualbox)
awx                       not created (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
```

To ssh into the Ansible controller:

```bash
vagrant ssh ansible
```

To ssh into Ansible AWX:

```bash
vagrant ssh awx
```

To ssh into one of the nodes:

```bash
vagrant ssh node1
vagrant ssh node2
```

### Destroying the environment
If you are done, or you want a clean environment, you can destroy the Vagrant environment. This will also destroy your AWX instance!

```bash
vagrant destroy -f
```
