#!/bin/bash

exec > >(tee -i /var/log/user-data.log)
exec 2>&1
sudo apt-get update -y
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y 
sudo apt install git -y
mkdir Ansible && cd Ansible/
pwd 
git clone https://github.com/suryaaws15/Ansible.git
cd Ansible/
ansible-playbook -i localhost Jenkins-playbook.yml

