#!/usr/bin/env bash

set -ex

until_date=$(date +'%Y-%m-%dT%H:%M:%S' --date='-15 days')
sudo podman system prune --all --filter "until=${until_date}"
