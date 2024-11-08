#!/usr/bin/env bash

set -ex

./stop.sh
./install.sh
./start.sh
./configure.sh

#dask
farm_0_ip=$(sudo podman inspect systemd-farm_0 | jq --raw-output '.[0].NetworkSettings.Networks."systemd-cluster".IPAddress')
firefox "${farm_0_ip}:8787"

#cockpit
control_ip=$(sudo podman inspect systemd-control_0 | jq --raw-output '.[0].NetworkSettings.Networks."systemd-cluster".IPAddress')
firefox "${control_ip}:9090"

./podshell.sh
exit
