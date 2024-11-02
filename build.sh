#!/usr/bin/env bash

set -ex

for cf in containers/*.Containerfile; do
    name=$(basename "${cf}" .Containerfile)
    version=$(git describe --always --dirty)
    sudo podman build \
        -f "${cf}" \
        -t "${name}":latest \
        .
    sudo podman tag \
        "${name}":latest "${name}":"${version}"
done
sudo podman image list
