#!/usr/bin/env bash

set -ex

./stop.sh
./install.sh
./start.sh
./configure.sh

./podshell.sh
exit

ip=$(sudo podman inspect systemd-control_0 | jq --raw-output '.[0].NetworkSettings.Networks."systemd-cluster".IPAddress')
firefox "${ip}:9090"
exit
