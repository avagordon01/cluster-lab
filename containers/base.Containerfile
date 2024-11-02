FROM rockylinux:9
RUN dnf -y update
RUN dnf -y install systemd podman python3 bzip2

RUN curl -LsSf https://astral.sh/uv/install.sh | sh

RUN useradd -m -u 1000 -G wheel admin
RUN echo "root:pass" | chpasswd
RUN echo "admin:pass" | chpasswd
USER admin
WORKDIR /home/admin

RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
COPY services/ .config/systemd/user
COPY build/ build/
#RUN systemctl enable --user systemd-coredump reboot.timer
