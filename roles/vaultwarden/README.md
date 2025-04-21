# vaultwarden
This role installs vaultwarden, which is your password manager. 

For more information visit:  
[https://github.com/dani-garcia/vaultwarden](https://github.com/dani-garcia/vaultwarden)

# Role variables
```yaml
vaultwarden:
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