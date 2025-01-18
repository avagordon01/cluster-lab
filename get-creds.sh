#!/usr/bin/env bash

set -ex

account=605136152882-compute@developer.gserviceaccount.com

gcloud iam service-accounts keys create \
    --iam-account=${account} \
    service_account.json
