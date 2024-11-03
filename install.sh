#!/usr/bin/env bash

set -ex

sudo mkdir -p /etc/containers/systemd
sudo rm -f /etc/containers/systemd/*
for f in cluster/*.container; do
    sudo cp $f /etc/containers/systemd/
done
sudo cp cluster/cluster.target /etc/systemd/system

sudo systemctl daemon-reload
