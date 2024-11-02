FROM base:latest
USER root
#RUN dnf -y install ...
RUN systemctl enable podman-auto-update.timer
RUN source $HOME/.cargo/env && uv pip install --system dask jupyter systemd-coredump-python
CMD ["/sbin/init"]
