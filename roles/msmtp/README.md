# msmtp
This role installs msmtp, which can send you certain information about your system via e-mail.

For more information visit:  
[https://marlam.de/msmtp/](https://marlam.de/msmtp/)

# Role variables
```yaml
msmtp:
  - # Copy msmtp config file and sets the associated user 
    path: /etc/msmtprc
    user: root
    group: root
    # Enables authentication for your user credentials. 
    auth: "on"
    # Use of TLS encryption and trust file for TLS
    tls: "on"
    tls_trust_file: /etc/ssl/certs/ca-certificates.crt
    # Path of the logfile
    logfile: ~/.msmtp.log
    # Can be your email provider
    account: msmtp
    # Set your host like smtp.email.address
    host: localhost
    # smtp port
    smtp_port: 587
    # Add your user where the emails are coming from
    from_user: your@email.address
    # Your account user and password
    account_user: your@email.address
    account_user_password: password
```
