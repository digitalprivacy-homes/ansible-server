# Changelog

## 0.6.1 (12.09.2025)
### roles
#### tor
Added `{{ ansible_distribution_release }}-updates` repository and simplified `backports` code (just `Enabled: yes or no`) in `debian.source`.  
#### searxng
Changed `env` file because uWSGI got replaced with Granian (see https://github.com/searxng/searxng-docker/commit/8b75609524a9b6f93f35d9b0a13665da9deeb6d7)  
Deleted `static_use_hash` in `settings.yml` (see https://github.com/searxng/searxng-docker/commit/8de6ea65ab34ad2d3833cbf13b826c8162fc3269)  
Deleted `cap_drop` for the first run (see https://github.com/searxng/searxng-docker/commit/8fe0b98cedfcfbde3761e0850f1a0e7b94636c6f)  
Updated `docker-compose.yaml` file (see https://github.com/searxng/searxng-docker/commits/master/docker-compose.yaml)  
#### digitalprivacy
Changed `digitalprivacy-update_certificates.sh` to be able to run the whole script as a sudo user as well.  
Changed sed CHECKSUM command (line 23 & 24) to change only the pattern.
#### docker
Updated README.md.  
#### nginx
Changed download certificates-task (ansible.builtin.get_url) with `digitalprivacy-update_certificates.sh` via ansible.builtin.shell.  
Enabled `http2 on;` in `nginx.conf.j2` since it works on Debian 13.  
#### Cockpit
Deleted `include ...` bots/firewall block in `cockpit.digitalprivacy.homes`.  
#### unattended_upgrades
Added `52unattended-upgrades-local.j2` info blocks from original file.  
Deleted `.db` in `listchanges.conf.j2` line `save_seen=/var/lib/apt/listchanges`.  
### playbook-digitalprivacy.homes.yml
Moved the `reboot` role behind tor role because it seems to having some issues 
Moved the `reboot` role before the `AdGuardHome` role because there were issues with setting up the right IPs in `AdGuardHome.yaml`.  
Moved hardening roles (os & ssh) to the last position.  
Enabled `pre_tasks:` - `- name: Add server to the ssh configuration` which comes handy for first time installations via script `install_ansible_on_workstation.sh`. The lines for 131 to 141 (`# Creates a host under .ssh/config`) in the script itself shouldn't be necessary anymore but it needs more testing.  

## 0.6.0 (09.08.2025)
### Debian 13 (trixie)
The role(s) are now for Debian 13 (trixie).  
### roles
In all roles (where it had not yet been changed), the `boolean` value of `yes` or `no` was changed to `true` or `false`.  
Also in every `meta/main.yml` file changed versions `bookworm` to `trixie`.
#### reboot
The `reboot` role has been moved further up because the variable `ansible_default_ipv4.address|default(ansible_all_ipv4_addresses[0])` does not work on the first run. But the variable is needed for `digitalprivacy` and `adguardhome` roles.
#### tor
Updated `oniux` version to `v0.6.0`.  
Updated source lists to the new `debian.sources` format (https://wiki.debian.org/SourcesList#debian.sources_format).  
#### packages
Added `gnupg` package.
#### desec
`ddclient` role now will fail if no token has been received. So before it copies the config file and runs `ddclient -force`. The config file needs either the `ddclient` `token: $variable` (if it is already created, see the role `README.md`) or the new created one via task `ddclient_token`.  
#### docker
Updated source lists to the new `debian.sources` format (https://wiki.debian.org/SourcesList#debian.sources_format).  
#### unattended_upgrades
Wrong information link in `README.md`.
#### digitalprivacy
Added `ansible_default_ipv4.address|default(ansible_all_ipv4_addresses[0])` instead of just `ansible_default_ipv4.address` variable to `digitalprivacy-update_ip` script to ensure that the correct IP address is used.  
Added a condition to check if the `digitalprivacy` script is present in `~/.bashrc` and only adds it if it is not.  
Added `Reboot your system` and changed from `full-upgrade` to `upgrade` in the `digitalprivacy` script.
#### adguardhome
Added `ansible_default_ipv4.address|default(ansible_all_ipv4_addresses[0])` variable to the `rewrites: answer` to ensure that the correct IP address is used.

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