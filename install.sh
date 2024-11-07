#!/usr/bin/env bash

set -ex

sudo mkdir -p /etc/containers/systemd
sudo rm -f /etc/containers/systemd/*
sudo cp cluster/*.container /etc/containers/systemd/
sudo cp cluster/cluster.target /etc/systemd/system/
sudo cp cluster/cluster.network /etc/containers/systemd/

sudo systemctl daemon-reload
