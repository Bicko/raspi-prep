#!/bin/bash

#Install Ansible
apt -y install python-pip
pip install ansible

add-apt-repository -y ppa:ubuntu-pi-flavour-makers/ppa
apt-get update

#Install git
apt -y install git

#Get the repo, if not already present
cd ~
test ! -d raspi-prep && git clone https://github.com/Bicko/raspi-prep.git

#Get latest yaml, etc
cd raspi-prep && git pull

ansible-playbook ~/raspi-prep/playbook-02_rpi2-garage.yml
