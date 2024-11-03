# cluster-lab

this is a repo for my testing system/cluster management using systemd for everything

first run `./build.sh` to build containers and `./install.sh` to install systemd services

to start all machines and services:
```
sudo systemctl run cluster.target
```

open localhost:9090 to browse the cluster status, services, logs, etc

submit python tasks to dask:
```
#TODO
```

in a real world deployment, cluster/* would be some terraform instead
