FROM base:latest
RUN dnf update
RUN dnf install ...
RUN uv pip install --system dask jupyter systemd-coredump-python
RUN systemctl enable podman-auto-update.timer
