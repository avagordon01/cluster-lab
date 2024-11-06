#!/usr/bin/env bash

set -ex

sudo systemctl start cluster.target
sudo podman network create --ignore lab
