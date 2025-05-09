# Changelog

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