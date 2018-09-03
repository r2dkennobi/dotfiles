#!/bin/bash
set -e

function install_ansible()
{
    echo "Installing ansible"
    sudo apt-get install software-properties-common -y
    sudo apt-add-repository ppa:ansible/ansible -y
    sudo apt-get update
    sudo apt-get install ansible -y
}

echo "- Check if ansible is installed"
which ansible-playbook || install_ansible

echo "- Install ansible linter"
which pip2 || sudo apt-get install python-pip
which ansible-lint || sudo pip2 install ansible-lint

ansible-galaxy install -r requirements.yml
