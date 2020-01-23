#!/bin/bash

# change to the awx install directory
cd /opt/awx/installer

# execute ansible playbook to install awx
ansible-playbook -i inventory install.yml

# get ip address of ETH1
IP=$(ifconfig eth1 | grep inet | grep -v inet6 | awk '{ print $2 }')

# print ip address to use on the screen
echo ""
echo ""
echo "======================================================================="
echo "Provisioning of Ansible AWX completed!"
echo "You can access Ansible AWX via your web browser on your local machine:"
echo ""
echo "url:      http://${IP}"
echo "username: admin"
echo "password: password"
echo "======================================================================="