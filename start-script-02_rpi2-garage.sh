#!/bin/bash

#Install Ansible
sudo apt install python-pip
sudo pip install ansible

#Install git
sudo apt install git

#Get the repo, if not already present
cd ~
test ! -d raspi-prep && git clone https://github.com/Bicko/raspi-prep.git

#Get latest yaml, etc
cd raspi-prep && git pull

ansible-playbook ~/raspi-prep/playbook-02_rpi2-garage.yml
