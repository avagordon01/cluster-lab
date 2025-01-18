#!/usr/bin/env bash

set -ex

dag_bucket=$(gcloud composer environments describe example-environment \
    --project cluster-lab-2 \
    --location us-east1 \
    --format="get(config.dagGcsPrefix)")

gcloud storage rsync dags/ ${dag_bucket} \
    --recursive \
    --delete-unmatched-destination-objects
