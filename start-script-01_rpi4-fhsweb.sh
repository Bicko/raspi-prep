#!/bin/bash

#Install Ansible
sudo apt -y install python-pip
sudo pip install ansible

#Install git
sudo apt -y install git

#Get the repo, if not already present
cd ~
test ! -d raspi-prep && git clone https://github.com/Bicko/raspi-prep.git

#Get latest yaml, etc
cd raspi-prep && git pull

ansible-playbook ~/raspi-prep/playbook-01_rpi4-fhsweb.yml
