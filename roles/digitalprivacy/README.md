# digitalprivacy
This role installs digitalprivacy bash scripts. It also installs tor/socks to be able to use curl with tor (`curl --socks5-hostname 127.0.0.1:9050`) to download the certificates. It also gives you the opportunity to use torsocks with apt (`torsocks apt upgrade`).

# scripts

## digitalprivacy.sh
The main script (digitalprivacy.sh) is a whiptail bash script that shows a menu for certain things like updating your server IPs for AdGuardHome (rewrite domains).  
It's just a simple overview to update or find out certain details related to your server.  

## digitalprivacy-update_ip.sh 
This script updates the IP for AdGuardHome (rewrite domains) if the IP has changed.  

## digitalprivacy-update_certificates.sh
It downloads the letsencrypt certificates from [https://certificates.digitalprivacy.homes](https://certificates.digitalprivacy.homes) via tor if new certificates are available.

## The sripts are copied to your /usr/local/bin/ folder
You can use the scripts via command line:
```
digitalprivacy  
digitalprivacy-update_ip
digitalprivacy-update_certificates
```

## Crontab
The role also creates a crontab:  
```
#Ansible: Run digitalprivacy-update_ip.sh every reboot.
@reboot sleep 10s && /usr/local/bin/digitalprivacy-update_ip.sh > /dev/null 2>&1
#Ansible: Run digitalprivacy-update_certificates.sh every week.
@weekly /usr/local/bin/digitalprivacy-update_certificates.sh > /dev/null 2>&1
```

1. If your server obtains a new IP after a reboot, your services also adopt the new IP. This is to ensure that the services can still be accessed. However, the server IP must also be changed in your router or devices.      
2. Every week it checks for new letsencrypt certificates.

> Hint:  
> Try to set up a static IP address for your server.

# Role variables
No variables included in this role.  
Well, there are “ansible_default_ipv4.address”, "ansible_user" and "ansible_sudo_pass", but this cannot or should not be changed.