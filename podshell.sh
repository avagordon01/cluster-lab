#!/usr/bin/env bash

set -ex

sudo podman exec -it systemd-control_0 '/bin/bash' -c 'su admin'
