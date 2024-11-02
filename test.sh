#!/usr/bin/env bash

set -ex

sudo podman run --network=host control:latest
exit

sudo machinectl start control

machinectl start control farm farm farm farm prod prod prod prod
