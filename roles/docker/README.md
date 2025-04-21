# docker
This role adds the Docker repository to sources.list.d/docker.list and then installs docker.

> Hint:  
> Most of the services provided are based on Docker.

Currently changed (21.4.2025):  
> It also creates the docker daemon.json file under /etc/docker/daemon.json, which contains the IP DNS address of the server.

Using local DNS server for docker is currently changed in `/etc/default/docker` > `DOCKER_OPTS="--dns 127.0.0.1"`

For more information visit:  
[https://docs.docker.com/engine/install/debian/](https://docs.docker.com/engine/install/debian/)

# Role variables
No variables included in this role.   
Well, there is one “ansible_default_ipv4.address”, but this cannot or should not be changed.