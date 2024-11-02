#!/usr/bin/env bash

set -ex

source .env
echo $CR_PAT | sudo podman login ghcr.io -u avagordon01 --password-stdin
for cf in containers/*.Containerfile; do
    name=$(basename "${cf}" .Containerfile)
    version=$(git describe --always --dirty)
    sudo podman build \
        -f "${cf}" \
        -t "${name}":latest \
        .
    sudo podman tag \
        "${name}":latest "${name}":"${version}"
    sudo podman push "${name}":latest ghcr.io/avagordon01/"${name}":latest
    sudo podman push "${name}":"${version}" ghcr.io/avagordon01/"${name}":"${version}"
done
sudo podman image list
