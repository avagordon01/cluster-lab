#!/usr/bin/env bash

set -ex

for name in systemd-control_0 systemd-farm_{0,1,2,3} systemd-prod_{0,1,2,3}; do
    sudo podman container cp --archive=false .ssh ${name}:/home/admin/.ssh
done
