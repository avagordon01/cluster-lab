#!/usr/bin/env bash

set -ex

airflow_uri=$(
    gcloud composer environments describe example-environment \
        --project cluster-lab-2 \
        --location us-east1 \
        --format="get(config.airflowUri)"
)

firefox "${airflow_uri}"
