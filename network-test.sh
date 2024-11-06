#!/usr/bin/env bash

set -ex

./stop.sh
./install.sh
./start.sh
./podshell.sh
