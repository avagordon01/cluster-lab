FROM base:latest
USER root
#RUN dnf -y install ...
RUN systemctl enable podman-auto-update.timer
USER admin
RUN uv pip install --system dask jupyter systemd-coredump-python
