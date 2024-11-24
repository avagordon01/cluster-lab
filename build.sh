#!/usr/bin/env bash

set -ex

#build and tag
for cf in containers/*.Containerfile; do
    name=$(basename "${cf}" .Containerfile)
    version=$(git describe --always --dirty)
    name_l="${name}:latest"
    name_v="${name}:${version}"
    sudo podman build \
        -f "${cf}" \
        -t "${name_l}" \
        -t "${name_v}" \
        .
done

#login
source .env
echo $CR_PAT | sudo podman login ghcr.io -u avagordon01 --password-stdin
gh_cr="ghcr.io/avagordon01"
GCP_AT=$(gcloud auth print-access-token)
echo $GCP_AT | sudo podman login -u oauth2accesstoken --password-stdin us-east1-docker.pkg.dev
gcp_cr="us-east1-docker.pkg.dev/golden-imprint-442423-f2/cr"

#push to registries
for cf in containers/*.Containerfile; do
    name=$(basename "${cf}" .Containerfile)
    version=$(git describe --always --dirty)
    name_l="${name}:latest"
    name_v="${name}:${version}"
    sudo podman push "${name_l}" "${gh_cr}/${name_l}"
    sudo podman push "${name_v}" "${gh_cr}/${name_v}"
    sudo podman push "${name_l}" "${gcp_cr}/${name_l}"
    sudo podman push "${name_v}" "${gcp_cr}/${name_v}"
done
