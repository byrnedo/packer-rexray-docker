apt-get autoremove
apt-get update

## otherwise all instances get the same docker node id and swarm doesn't like that
rm -f /root/.docker/key.json /etc/docker/key.json
