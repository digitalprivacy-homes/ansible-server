# firewalld
This role installs and configures (firewalld) the public zone as the default zone and adds your interface to the public zone.  
Basic ports are also opened in order to access your services. Everything else gets blocked.

> __WARNING__  
> Always establish an ssh connection when performing this role!  
> And check that your `interface` is in the correct zone and has the correct `ssh_port` open!

# Role variables
```yml
firewalld:
    - # If you don't use ssh, set to `false`. 
      allow_ssh_ports: true
      ssh_port: "{{ ansible_port }}"
      # If you are using this role on a desktop PC, it may not be necessary to enable http/s ports.
      # So set it to `false` if you do not want to open the http/s ports.
      allow_https_ports: true
      # It's set you interface for the specific zone.
      public_interface: "{{ ansible_default_ipv4.interface }}"
```