# tor
This role installs tor and oniux.

For more information visit:  
[https://www.torproject.org/](https://www.torproject.org/) and [oniux](https://blog.torproject.org/introducing-oniux-tor-isolation-using-linux-namespaces/) ([source code](https://gitlab.torproject.org/tpo/core/oniux))

# Role variables
```yaml
tor:
  - # HINT: oniux is beta and is very likely to fail!
    # Change `install_oniux` to `true` if you want to install oniux. Default is `false`. It needs backports to be enabled as well!
    install_oniux: false
    # Enable backports repo (default is false).
    backports: false
```