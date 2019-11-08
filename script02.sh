#!/bin/bash

#Install Ansible
sudo apt install python-pip
sudo pip install ansible

wget https://raw.githubusercontent.com/Bicko/raspi-prep/master/playbook.yml > playbook.yml
ansible-playbook playbook.yml
