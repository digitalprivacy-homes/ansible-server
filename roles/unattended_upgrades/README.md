# unattended_upgrades
This role configurate unattended_upgrades, which is used to automatically update your system. It installs the unattended-upgrades, apt-listchanges and needrestart packages.

For more information visit:  
[https://www.portainer.io/](https://www.portainer.io/)

# Role variables
Delete // (to enable) or add // (to disable) before the actual line starts.
```yaml
unattended_upgrades:
    - # Automatically upgrade packages (on by default)
      unattended_updates: '        "origin=Debian,codename=${distro_codename}-updates";'
      # More info https://www.debian.org/releases/proposed-updates
      unattended_proposed: '//      "origin=Debian,codename=${distro_codename}-proposed-updates";'
      # Minimalsteps splits the upgrade into the smallest possible chunks so that they can be interrupted with SIGTERM. 
      # This makes the upgrade a bit slower but it has the benefit that shutdown while a upgrade is running is possible (with a small delay)
      unattended_minimalsteps: 'Unattended-Upgrade::MinimalSteps "true";'
      # Send email for problems or packages upgrades
      unattended_mail: '//Unattended-Upgrade::Mail "your@email.address";'
      # Set this value to one of: "always", "only-on-error" or "on-change"
      # If this is not set, then any legacy MailOnlyOnError (boolean) value is used to chose between "only-on-error" and "on-change"
      unattended_mailreport: '//Unattended-Upgrade::MailReport "on-change";'
      # Remove unused automatically installed kernel-related packages (kernel images, kernel headers and kernel version locked tools).
      unattended_unusedkernel: 'Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";'
      # Do automatic removal of newly unused dependencies after the upgrade
      unattended_unusednewdependencies: 'Unattended-Upgrade::Remove-New-Unused-Dependencies "true";'
      # Do automatic removal of unused packages after the upgrade (equivalent to apt-get autoremove)
      unattended_unuseddependencies: 'Unattended-Upgrade::Remove-Unused-Dependencies "true";'
      # Automatically reboot *WITHOUT CONFIRMATION* if the file /var/run/reboot-required is found after the upgrade
      unattended_reboot: 'Unattended-Upgrade::Automatic-Reboot "true";'
      # If automatic reboot is enabled and needed, reboot at the specific time instead of immediately
      unattended_reboottime: 'Unattended-Upgrade::Automatic-Reboot-Time "05:00";'
      # Verbose logging
      unattended_verbose: 'Unattended-Upgrade::Verbose "false";'
      # apt-listchanges can compare a new version of a package with the one currently installed and show what has been changed, by extracting the relevant entries from the Debian changelog and NEWS files and sends it to your email address.
      listchanges_email: 'your@email.address'
```