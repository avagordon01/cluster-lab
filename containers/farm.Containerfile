FROM base:latest
USER root
#RUN dnf -y install ...
RUN systemctl enable podman-auto-update.timer
RUN source $HOME/.local/bin/env && \
    uv pip install --system \
    dask distributed "bokeh!=3.0.*,>=2.4.2" \
    jupyter jupyter-server-proxy systemd-coredump-python
#dask
RUN systemctl enable dask-worker.service dask-scheduler.service
EXPOSE 8786 8787
CMD ["/sbin/init"]
