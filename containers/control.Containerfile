FROM base:latest
USER root
RUN dnf -y install nginx cockpit-ws
#cockpit
RUN systemctl enable cockpit.socket
EXPOSE 9090
COPY cluster.json /etc/cockpit/machines.d/
CMD ["/sbin/init"]
