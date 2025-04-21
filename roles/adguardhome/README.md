# AdGuardHome
This role installs AdGuardHome, which acts as your DNS server to block ads, trackers, rewrites domains etc..

For more information visit:  
[https://github.com/AdguardTeam/AdGuardHome](https://github.com/AdguardTeam/AdGuardHome)  
[https://adguard.com/adguard-home/overview.html](https://adguard.com/adguard-home/overview.html)

# Role variables
See main.yml file under default as well.
```yaml
adguardhome:
      # Default user_name is your ansible user name.
    - user_name: "{{ ansible_user }}"
      # Default password is dprivacy as hash. Change it after logged in or create another hash `mkpasswd -m bcrypt -R 10 <password>`.
      user_password: $2a$10$P0jj3MzB8GnAjuorV6gbFu.3S3Zhc2MGl1EOJ4pIy8gjdd9uDXz4i
      # Default fall back dns is dnscrypt digitalprivacy.diy-dnscrypt-ipv4. See a list here https://dnscrypt.info/public-servers/ if you want to change it.
      fallback_dns:
      # Parental control (blocking adult domains). You can also unlock specific domains for specific clients if you wish under https://adguardhome.digitalprivacy.homes/#custom_rules - @@||example.com^$client='your_computer'
      parental_enabled: true
      # Acts as an automated filter of pornography and other potentially offensive and inappropriate content. 
      safebrowsing_enabled: true
      # Adds DNS blocklists like https://github.com/StevenBlack/hosts, https://github.com/hagezi/dns-blocklists, ... .
      filters:
      # The services (which are associated with the installation of digitalprivacy.homes) such as nextcloud.digitalprivacy.homes are ignored in the list of “Top queried domains”.
      statistics_ignored:
      # To reach every service (which are associated with the installation of digitalprivacy.homes) such as nextcloud.digitalprivacy.homes, it must be redirected to your server. Otherwise, your devices will search the Internet for these services.
      rewrites:
```