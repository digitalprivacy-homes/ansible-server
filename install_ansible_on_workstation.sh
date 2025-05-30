#!/bin/bash
# This script is made from and for https://digitalprivacy.homes (DIGITAL PRIVACY for every home).
# It installs Ansible on your Linux workstation and runs the playbook to deploy multiple services on your Debian server and also to harden your server.
# Repo: https://codeberg.org/digitalprivacy-homes/ansible-server
# License: GPL-3.0-or-later

# exit on error
#set -e

# Determine OS
OS=$(cat /etc/os-release | grep "^ID=" | cut -d = -f 2)
VERSION=$(cat /etc/os-release | grep "^VERSION_ID=" | cut -d \" -f 2)
# Installs necessary packages to run the script.
PACKAGES="wget sshpass"

if [[ $OS = debian ]] && [[ $VERSION = 12 ]]; then
  # Add Ansible Ubuntu-PPA repository (https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-debian).
  UBUNTU_CODENAME=jammy
  echo "Add Ansible Ubuntu-PPA repository."
  printf "\n"

  sudo apt install $PACKAGES gpg -y
  wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | sudo gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/ansible.list
  sudo apt update
  sudo apt install ansible -y

elif [[ $OS = debian ]] && [[ $VERSION = 11 ]]; then
  # Add Ansible Ubuntu-PPA repository (https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-debian).
  UBUNTU_CODENAME_FOCAL=focal
  echo "Add Ansible Ubuntu-PPA repository."
  printf "\n"

  sudo apt install $PACKAGES gpg -y
  wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | sudo gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME_FOCAL main" | sudo tee /etc/apt/sources.list.d/ansible.list
  sudo apt update
  sudo apt install ansible -y

elif [[ $OS = arch ]]; then
  sudo pacman -S ansible $PACKAGES

elif [[ $OS = ubuntu ]] && [[ $VERSION = 25.04 || $VERSION = 24.04 || $VERSION = 22.04 || $VERSION = 20.04 ]] || [[ $OS = linuxmint ]]; then
  sudo apt update
  sudo apt install software-properties-common -y
  sudo add-apt-repository --yes --update ppa:ansible/ansible
  sudo apt install ansible $PACKAGES -y

elif [[ $OS = ubuntu ]] && [[ $VERSION = 18.04 || $VERSION = 16.04 || $VERSION = 14.04 ]]; then
  sudo apt-get update
  sudo apt-get install python-software-properties -y
  sudo add-apt-repository --yes ppa:ansible/ansible
  sudo apt-get update
  sudo apt-get install ansible $PACKAGES -y

elif [[ $OS = \"rocky\" ]] || [[ $OS = fedora ]]; then
  sudo dnf install epel-release -y
  sudo dnf install ansible $PACKAGES -y

elif [[ $OS = \"opensuse-tumbleweed\" ]] || [[ $OS = \"opensuse-leap\" ]]; then
  sudo zypper install -y ansible $PACKAGES

elif [[ $OS = alpine ]]; then
  sudo apk update
  sudo apk add ansible $PACKAGES

else
  echo "No compatible OS."
  exit 1
fi

printf "\n"

# Installation of Ansible
## Confirmation of the installation of Ansible
echo "The next step creates an ansible folder in your home folder '~/ansible/' and an ansible.cfg file under '~/.ansible.cfg' (it overwrites the existing one, if available!). Plus all the necessary files in folder ~/ansible/*."
read -p "Is that okay? [y/n]" yn

if [[ $yn = [Yy] ]]; then
  ## Creates ansible folder under ~/ansible/{logs,host_vars,roles,playbooks,vars}
  mkdir -p ~/ansible/{logs,host_vars,roles,playbooks,vars}

  ## Creates ansible.cfg file under ~/ansible/ansible.cfg and creates a symlink to ~/.ansible.cfg
  echo "[defaults]
# hosts file
inventory = ~/ansible/hosts

# path
roles_path = ~/ansible/roles
log_path = ~/ansible/logs/ansible.log
collections_path = ~/ansible/ansible_collections

# Disabling 'host_key_checking' allows the server to be set up quickly on the first connection to set up the pubkey (no confirmation required).
host_key_checking = false" >~/ansible/ansible.cfg

  ln -s ~/ansible/ansible.cfg ~/.ansible.cfg

  ## Creates hosts file under ~/ansible/hosts
  echo "[home]
digitalprivacy.homes" >~/ansible/hosts

  ## Creates digitalprivacy.homes.yml file under ~/ansible/host_vars
  ## And asks for the password, username and ssh port to access your server.
  printf "\n"
  echo "The following username and password prompt is your user from your Debian server."
  read -p "What is the username of your debian server?" username
  read -s -p "And the sudo password?" password
  printf "\n"
  read -p "What is the ssh port number of your debian server?" port
  echo "---
ansible_port: $port
ansible_user: $username
ansible_sudo_pass: $password

# dev-sec hardening https://github.com/dev-sec/ansible-collection-hardening/
## os_hardening:
sysctl_overwrite:
      net.ipv4.ip_forward: 1

## ssh_hardening:
ssh_server_ports: 
  - '{{ ansible_port }}'
ssh_allow_users: '{{ ansible_user }}'
ssh_host_key_files: 
  - '/etc/ssh/ssh_host_ed25519_key'
ssh_max_auth_retries: 2
ssh_max_sessions: 2
ssh_banner: true
ssh_banner_path: '/etc/issue.net'" >~/ansible/host_vars/digitalprivacy.homes.yml

  # Creates a host under .ssh/config
  printf "\n\n"
  echo "The following creates a host under .ssh/config"
  mkdir ~/.ssh
  read -p "What is your server ip address?" ipaddress
  echo "Host digitalprivacy.homes
    HostName $ipaddress
    User $username
    Port $port
    IdentitiesOnly yes
    IdentityFile '~/.ssh/digitalprivacy.homes_ed25519'" >>~/.ssh/config

  # Installs digitalprivacy_homes.server and devsec.hardening ansible-galaxy collections
  printf "\n\n"
  echo "Installation of digitalprivacy_homes.server and devsec.hardening from ansible-galaxy to install the roles for providing the services on your server and to harden your server."
  ansible-galaxy collection install digitalprivacy_homes.server devsec.hardening

  # Downloads the Ansible playbook from codeberg repo and runs it.
  echo "Download the Ansible playbook and starts it."
  wget https://codeberg.org/digitalprivacy-homes/ansible-server/raw/branch/main/playbook-digitalprivacy.homes.yml -O ~/ansible/playbooks/playbook-digitalprivacy.homes.yml
  echo "The playbook will be started up. Please enter your user password from the server."
  ansible-playbook ~/ansible/playbooks/playbook-digitalprivacy.homes.yml --ask-pass
else
  echo "You pushed n for no, 'not okay'. The script has been canceled."
fi
