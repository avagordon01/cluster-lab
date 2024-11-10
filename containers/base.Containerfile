FROM rockylinux:9

RUN useradd -m -u 1000 -G wheel admin
RUN useradd pcp
RUN echo "root:pass" | chpasswd
RUN echo "admin:pass" | chpasswd

USER root
WORKDIR /root/
RUN dnf -y update
RUN dnf -y install systemd sudo openssh-clients openssh-server podman podman-plugins python3 bzip2 cockpit cockpit-pcp cockpit-system pcp-zeroconf
#NOTE this is necessary to workaround a bug in pcp/pmlogger
RUN chown -R pcp:pcp /var/log/pcp
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN systemctl disable auditd
#google ops agent supports systemd_journald log collection
#https://cloud.google.com/logging/docs/agent/ops-agent/configuration#logging-receivers
RUN curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
RUN bash add-google-cloud-ops-agent-repo.sh --also-install
COPY config/google-ops-agent.yaml /etc/google-cloud-ops-agent/config.yaml
#pmcd
EXPOSE 44321
#sshd
RUN systemctl enable sshd
EXPOSE 22

USER admin
WORKDIR /home/admin
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
COPY services/ /etc/systemd/system/
COPY build/ build/
