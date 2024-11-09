#!/usr/bin/env bash

set -ex

sudo podman ps --all --format "{{.Names}}" > containernames.txt
sudo podman ps --all --format "{{.Names}}" | sed 's/systemd-//;s/_/-/' > hostnames.txt

for name in $(cat containernames.txt); do
    sudo podman container cp --archive=false .ssh ${name}:/home/admin/.ssh
done
sleep 5
sudo podman exec -it --user root systemd-control_0 /bin/ssh-keyscan $(cat hostnames.txt) > known_hosts
sudo podman cp --archive=false known_hosts systemd-control_0:/etc/ssh/ssh_known_hosts
