# cluster-lab

this is a repo for my testing system/cluster management using systemd for everything

## dependencies

### local systemd cluster

```
sudo pacman -Syu systemd podman
```

### remote pulumi cluster

- [gcloud cli](https://cloud.google.com/sdk/docs/install)
- pulumi
  ```
  uv pip install pulumi pulumi-gcp
  ```

## usage

### local systemd cluster

first run `./build.sh` to build containers then
```
./cluster-systemd/scripts/test.sh
```
to bring up the cluster, and open firefox with cockpit and dask dashboards

submit python tasks to dask:
```
#TODO
```

### remote pulumi cluster

```
./cluster-pulumi/scripts/first-run.sh
./cluster-pulumi/scripts/test.sh
```
