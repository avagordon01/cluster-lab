#!/usr/bin/env bash

set -ex

sudo mkdir -p /etc/containers/systemd
sudo rm -f /etc/containers/systemd/*
sudo cp cluster-systemd/*.container /etc/containers/systemd/
sudo cp cluster-systemd/cluster.network /etc/containers/systemd/
sudo cp cluster-systemd/cluster.slice /etc/systemd/system/

sudo systemctl daemon-reload
