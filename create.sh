#!/usr/bin/env bash

set -ex

gcloud projects create cluster-lab-2 || true

pushd terraform
terraform init
terraform apply
popd

# test connection
# gcloud compute ssh \
#     ava@"dev-0" \
#     --zone "us-east1-c" \
#     --project "cluster-lab-2" \
#     --ssh-key-file=$(realpath ssh/google_compute_engine)
# exit
# ssh root@34.23.219.44 -i ssh/google_compute_engine
# exit

pushd ansible
uv run ansible-playbook -i gcp.yaml playbook.yaml
popd
