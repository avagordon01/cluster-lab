FROM base:latest
RUN dnf update
RUN dnf install nginx cockpit cockpit-system cockpit-ws
RUN systemctl enable cockpit.service podman-auto-update.service
