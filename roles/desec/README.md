# deSEC
This role takes care of the registration process on deSEC.io. It creates an account and a domain for DynDNS. Installs `ddclient` to automatically update the public IP for the new domain or simply run the role to update your DynDNS IP via Ansible.  

For more information visit:  
[https://desec.io](https://desec.io) and [https://desec.readthedocs.io/en/latest/auth/account.html#manage-account](https://desec.readthedocs.io/en/latest/auth/account.html#manage-account)

# Role variables
```yaml
desec:
  - # Change to `create_account` `true` if you want to create an account. Default is `false`.
    create_account: false
    email: ''
    password: ''
    domain: ''
    # Use this variable if you have an `ddclient` token already.
    token: ''
```