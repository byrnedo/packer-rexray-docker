# Docker rexray swarm vagrantfile

This will create 3 vms

- Consul vm
- Swarm master
- Swarm node

Rexray is installed on all nodes as well.

## Prerequisites

- Install Virtualbox provider for Vagrant
- Install Docker machine
- Make sure to run `ivboxwebsrv -H 0.0.0.0 -v  -b` before doing `vagrant up` as rexray uses vagrant to dynamically create docker volumes. 

