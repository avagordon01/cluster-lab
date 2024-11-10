#!/usr/bin/env bash

set -ex

source .env
echo $CR_PAT | sudo podman login ghcr.io -u avagordon01 --password-stdin
for cf in containers/*.Containerfile; do
    #build and tag
    name=$(basename "${cf}" .Containerfile)
    version=$(git describe --always --dirty)
    name_l="${name}:latest"
    name_v="${name}:${version}"
    sudo podman build \
        -f "${cf}" \
        -t "${name_l}" \
        -t "${name_v}" \
        .
    #push to ghcr
    sudo podman push "${name_l}" "ghcr.io/avagordon01/${name_l}"
    sudo podman push "${name_v}" "ghcr.io/avagordon01/${name_v}"
done
