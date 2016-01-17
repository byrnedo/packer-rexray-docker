#!/bin/bash

set -euo pipefail

function getIfaceIP {
    ifconfig "$1" | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'
}

CONSUL_IP="$(getIfaceIP eth1)"
CONSUL_DOCKER_BRIDGE_IP=$(getIfaceIP docker0)

set +e
RUNNING=$(docker inspect --format '{{.State.Running}}' consul-agent 2>/dev/null)
set -e

case $RUNNING in
    true)
        echo "Consul already running"
        ;;
    false)
    docker start consul-agent
        ;;
    *)
    docker run -d \
        --name consul-agent \
        --restart always \
        -p ${CONSUL_IP}:8300:8300 \
        -p ${CONSUL_IP}:8301:8301 \
        -p ${CONSUL_IP}:8301:8301/udp \
        -p ${CONSUL_IP}:8302:8302 \
        -p ${CONSUL_IP}:8302:8302/udp \
        -p ${CONSUL_IP}:8400:8400 \
        -p ${CONSUL_IP}:8500:8500 \
        -p ${CONSUL_DOCKER_BRIDGE_IP}:53:53 \
        progrium/consul -server -bootstrap -advertise $CONSUL_IP -ui-dir /ui
        ;;
esac

