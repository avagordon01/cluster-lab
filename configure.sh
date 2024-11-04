#!/usr/bin/env bash

set -ex

sudo echo
(
echo "{"
for name in systemd-control_0 systemd-{farm,prod}_{0,1,2,3}; do
    ip=$(sudo podman inspect -f "{{ .NetworkSettings.IPAddress }}" "${name}")
    echo "\"${name}\": {\"address\": \"${ip}\"},"
done
echo "}"
) > cluster.json

sudo podman container cp cluster.json systemd-control_0:/etc/cockpit/machines.d/
