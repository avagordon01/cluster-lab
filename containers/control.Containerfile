FROM base:latest
USER root
RUN dnf -y install nginx cockpit-ws
RUN systemctl enable cockpit.socket podman-auto-update.service
EXPOSE 9090
COPY cluster.json /etc/cockpit/machines.d/
CMD ["/sbin/init"]
