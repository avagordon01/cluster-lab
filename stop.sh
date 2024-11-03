#!/usr/bin/env bash

set -ex

sudo systemctl stop {control,farm,prod}@{0,1,2,3}.service
