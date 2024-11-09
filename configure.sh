#!/usr/bin/env bash

set -ex

sudo podman ps --all --format "{{.Names}}" > containernames.txt
sudo podman ps --all --format "{{.Names}}" | sed 's/systemd-//;s/_/-/' > hostnames.txt

for name in $(cat containernames.txt); do
    sudo podman container cp --archive=false .ssh ${name}:/home/admin/.ssh
done
