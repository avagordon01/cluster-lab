FROM rockylinux:9
RUN dnf update
RUN dnf install systemd podman python3 uv micromamba
RUN systemctl enable systemd-coredump reboot.timer
