FROM base:latest
USER root
#RUN dnf -y install ...
RUN systemctl enable podman-auto-update.timer
RUN source $HOME/.cargo/env && uv pip install --system dask jupyter systemd-coredump-python
#dask
#RUN systemctl enable --user dask-worker.service dask-scheduler.service
#EXPOSE 8786 8787
CMD ["/sbin/init"]
