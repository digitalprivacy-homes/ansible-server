# Changelog

## 0.5.0 (27.07.2025)
### roles
#### tor
Added new tor role.  
Which installs tor via tor repository (https://support.torproject.org/apt/tor-deb-repo/) and installs oniux (https://blog.torproject.org/introducing-oniux-tor-isolation-using-linux-namespaces/) if set to true (Default is false. oniux is also still beta.).
#### digitalprivacy
Changed certificate links to tor links.  
Deleted torsocks installation and apt upgrade via torsocks (tor source.list in place now).
### playbook-digitalprivacy.homes.yml
Added tor role.

## 0.4.1 (20.07.2025)
### roles
#### portainer
Added trusted origins environments. See https://www.portainer.io/blog/origin-invalid-errors-with-portainer-2.27.7-behind-reverse-proxies

## 0.4.0 (08.06.2025)
### roles
#### New role - desec
Added [desec.io](https://desec.io) to use it as a dyndns option for wg-easy (wireguard).  
It creates an account, updates the domain (dyndns) IP address and install ddclient including desec config.  
#### wg_easy
Added info about desec domains (dyndns) if available to use it as the host instead of the public IP.  
### playbook-digitalprivacy.homes.yml
Added desec role.

## 0.3.0 (02.06.2025)
### roles
#### wg_easy
Updated wg-easy to v15.  
Moved `docker-compose.yml` to files instead of templates (no variables necessary anymore).  
Added `community.general.ipify_facts` to get public IP and `msg` with `ansible.builtin.debug` IPv4 AND ipV6 IPs.  
Open `51820/udp` port in firewalld.  
#### adguardhome
Added `user_rules` variables which can be used to allow certain domains that could be blocked by some filters.  
Allow `api.ipify.org` in `user_rules`, which is necessary for the `wg_easy` role to get the public IP address.  
#### docker
Added docker.service override.conf file to make docker.service start after AdGuardHome.service and unbound.service.  
### playbook-digitalprivacy.homes.yml
Enabled wg-easy role.  
### README.md
Deleted "(soon)" message for wg-easy.  
Added "update" and "remove" info of the collection.  

## 0.2.0 (25.05.2025)
### roles
#### digitalprivacy
Fixed issue [Add checksum and sign certificates](https://codeberg.org/digitalprivacy-homes/ansible-server/issues/6).  
Fixed issue [digitalprivacy-update_ip.sh script overwrites every dns_rewrites](https://codeberg.org/digitalprivacy-homes/ansible-server/issues/1)  
Added license, repo etc. in all digitalprivacy* scripts.  
### README.md
Added milestone link to New Features/Projects.

## 0.1.0 (17.05.2025)
### install_ansible_on_workstation.sh
Added rockylinux, opensuse, ubuntu, linux mint and fedora to install ansible on the workstation [issue](https://codeberg.org/digitalprivacy-homes/ansible-server/issues/3). It also includes multiple versions of some of the distrobutions.  
Changed hosts to `digitalprivacy.homes` and added ssh to make it clear which port it means.  
Disabled “exit on error" to ensure a smooth process during the tests and to be able to run the script several times until a proper solution is elaborated.
### roles
#### firewalld
Deleted the last task in the firewalld role "Start and activate firewalld". This is done automatically after the installation of firewalld (under Debian).  
### playbook
Deleted Nextcloud “...press Enter to continue” `post_tasks` `msg` in the playbook. This used to be part of the Nextcloud role itself (as a prompt) and has been moved to the post_task in the playbook and is no longer necessary as the playbook is finished after this message.   

## 0.0.4 (09.05.2025)
Added http**s** for documentation link and changed to FAQ in galaxy.yml.  
Changed role **firewalld** `dependencies: []` in meta.  
Changed role path in the playbook example to the galaxy installation path.  
Added exit on error in `install_ansible_on_workstation.sh` script.

## 0.0.3 (27.04.2025)
Added `digitalprivacy.homes.yml` example `host_vars` file.  
Added `playbook-digitalprivacy.homes.yml` example file.  
Changed requirement of ansible to `v2.15.0`.  
Added `meta` for every role.  
Added `modules` in roles.  
Deleted `community.general` dependency in galaxy.yml.  
Added build folder for old `ansible-galaxy collection build`.  
Added `build` folder to build ignore in galaxy.md.

## 0.0.2 (21.04.2025)
Changed repository to codeberg in galaxy.yml.  
Added `digitalprivacy` tag in galaxy.yml.  
Added `install_ansible_on_workstation.sh` to build ignore in galaxy.md.

## 0.0.1 (21.04.2025)
Initial release