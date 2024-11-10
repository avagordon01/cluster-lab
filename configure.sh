#!/usr/bin/env bash

set -ex

sudo podman ps --all --format "{{.Names}}" > containernames.txt
sudo podman ps --all --format "{{.Names}}" | sed 's/systemd-//;s/_/-/' > hostnames.txt
cat hostnames.txt | jq --raw-input --null-input \
    '[{"address": inputs, "visible": true}] | INDEX(.address)' > cluster.json

sudo podman exec -it --user root systemd-control_0 /bin/ssh-keyscan $(cat hostnames.txt) > .ssh/known_hosts
for name in $(cat containernames.txt); do
    sudo podman container cp --archive=false .ssh ${name}:/home/admin/.ssh
done
sudo podman cp --archive=false cluster.json systemd-control_0:/etc/cockpit/machines.d/cluster.json
