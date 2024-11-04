FROM rockylinux:9
RUN dnf -y update
RUN dnf -y install systemd sudo openssh-clients openssh-server podman python3 bzip2 cockpit cockpit-pcp cockpit-system

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
USER root
RUN systemctl enable sshd.service
EXPOSE 22
