#!/usr/bin/env bash

set -ex

./cluster-systemd/scripts/stop.sh
sleep 2
./cluster-systemd/scripts/install.sh
./cluster-systemd/scripts/start.sh
sleep 10
./cluster-systemd/scripts/configure.sh

#dask
farm_0_ip=$(sudo podman inspect systemd-farm_0 | jq --raw-output '.[0].NetworkSettings.Networks."systemd-cluster".IPAddress')
firefox "${farm_0_ip}:8787"

#cockpit
control_ip=$(sudo podman inspect systemd-control_0 | jq --raw-output '.[0].NetworkSettings.Networks."systemd-cluster".IPAddress')
firefox "${control_ip}:9090"

./cluster-systemd/scripts/podshell.sh
exit
