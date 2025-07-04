# Ansible Server
Run ansible for a simple setup of your server that includes digital privacy services.

## Description
This collection provides solutions for digital privacy that are only intended for home use.

- Linux operating system:
  - Debian 12
  
- Services:
  - adguardhome
  - cockpit
  - docker
  - firewalld
  - msmtp
  - nginx
  - portainer
  - searxng
  - unattended_upgrades
  - unbound
  - vaultwarden
  - wg-easy (wireguard)

## Using this collection
Please refer to the examples in the readmes of the role.

See [Ansible Using collections](https://docs.ansible.com/ansible/latest/user_guide/collections_using.html) for more details.

### Installation
Install the collection via ansible-galaxy:

`ansible-galaxy collection install digitalprivacy_homes.server`

### Update
Update the collection:

`ansible-galaxy collection install --upgrade digitalprivacy_homes.server`

### Remove
Remove the collection:

`rm -rf digitalprivacy_homes/`

## New Features/Projects
- [ntfy](https://codeberg.org/digitalprivacy-homes/ansible-server/projects/16121)
- [Milestones](https://codeberg.org/digitalprivacy-homes/ansible-server/milestones)

## Licensing
Licensed under GNU GENERAL PUBLIC LICENSE Version 3