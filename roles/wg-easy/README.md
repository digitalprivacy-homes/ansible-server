# wg-easy
This role installs wg-easy, which is an easy way to use wireguard (VPN). 

For more information visit:  
[https://github.com/wg-easy/wg-easy](https://github.com/wg-easy/wg-easy)

# Role variables
```yaml
wireguard:
    - # General settings
      domain: "https://vaultwarden.digitalprivacy.homes"
      ## Controls if new users can register
      signups: "true"
      ## Invitations org admins to invite users, even when signups are disabled
      invitations: "true"

      # SMTP Email settings
      ## smtp needs to be set to true if you want to use emails. It's by default set to false.
      use_smtp: true
      email_host: "smtp.email.address"
      email_port: "587"
      email_user: "your@email.address"
      email_pass: "your.email.password"
      email_from: "your@email.address"
      email_tls: "starttls"
      email_timeout: "15"
      email_from_name: vaultwarden.digitalprivacy.homes
```