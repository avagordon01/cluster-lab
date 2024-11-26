FROM base:latest
USER root
RUN dnf -y install nginx cockpit-ws && \
    dnf clean all
#cockpit
RUN systemctl enable cockpit.socket
EXPOSE 9090
