FROM base:latest
USER root
RUN dnf -y install nginx cockpit cockpit-system cockpit-ws
RUN systemctl enable cockpit.socket podman-auto-update.service
EXPOSE 9090
CMD ["/sbin/init"]
