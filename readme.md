# cluster-lab

this is a repo for my testing system/cluster management using systemd for everything

## dependencies

```
sudo pacman -Syu systemd podman pulumi
```

## usage - local systemd cluster

first run `./build.sh` to build containers and `./cluster-systemd/scripts/install.sh` to install systemd services

run `./cluster-systemd/scripts/test.sh` to bring up the cluster, and open firefox with cockpit and dask dashboards

submit python tasks to dask:
```
#TODO
```

## usage - remote pulumi cluster

TODO
