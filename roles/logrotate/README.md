# logrotate
This role installs logrotate, which ensures that your log files do not overfill the disk space.  

# Role variables
```yaml
logrotate:
      # Enables logrotation for docker log files.
      docker_container: true
```
