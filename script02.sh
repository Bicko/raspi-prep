#!/bin/bash

#Install Ansible
sudo apt install python-pip
sudo pip install ansible

curl -sL https://raw.githubusercontent.com/Bicko/raspi-prep/master/playbook.yml
ansible-playbook playbook.yml
