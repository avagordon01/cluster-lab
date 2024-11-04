#!/usr/bin/env bash

set -ex

ip=$(sudo podman inspect -f "{{ .NetworkSettings.IPAddress }}" systemd-control_0)
firefox "${ip}:9090"
