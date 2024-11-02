#!/usr/bin/env bash

set -ex

source .env
echo $CR_PAT | sudo podman login ghcr.io -u avagordon01 --password-stdin
for cf in containers/*.Containerfile; do
    #build and tag
    name=$(basename "${cf}" .Containerfile)
    version=$(git describe --always --dirty)
    sudo podman build \
        -f "${cf}" \
        -t "${name}":latest \
        .
    sudo podman tag \
        "${name}":latest "${name}":"${version}"
    #push to ghcr
    sudo podman push "${name}":latest ghcr.io/avagordon01/"${name}":latest
    sudo podman push "${name}":"${version}" ghcr.io/avagordon01/"${name}":"${version}"
    #export to machinectl
    sudo podman save -o "${name}".tar localhost/base:latest
    sudo machinectl remove "${name}"
    sudo importctl import-tar --force --class=machine "${name}".tar
    rm -f "${name}".tar
done
sudo podman image list
machinectl list-images
