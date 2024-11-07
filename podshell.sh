#!/usr/bin/env bash

set -ex

sudo podman exec -it --user admin systemd-control_0 '/bin/bash'
