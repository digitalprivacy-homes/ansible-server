# Changelog

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