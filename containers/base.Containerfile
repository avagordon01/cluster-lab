FROM rockylinux:9

CMD ["/sbin/init"]

RUN useradd -m -u 1000 -G wheel admin
RUN useradd pcp
RUN echo "root:pass" | chpasswd
RUN echo "admin:pass" | chpasswd

USER root
WORKDIR /root/
RUN dnf -y update && \
    dnf -y install systemd sudo openssh-clients openssh-server podman podman-plugins python3 bzip2 cockpit cockpit-pcp cockpit-system pcp-zeroconf tuned unzip && \
    dnf clean all
RUN systemctl enable tuned
#NOTE this is necessary to workaround a bug in pcp/pmlogger
RUN chown -R pcp:pcp /var/log/pcp
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN systemctl disable auditd
#pmcd
EXPOSE 44321
#sshd
RUN systemctl enable sshd
EXPOSE 22
#rclone
RUN curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip
RUN unzip rclone-current-linux-amd64.zip
RUN cp rclone-*-linux-amd64/rclone /usr/bin
RUN rm -rf rclone-*-linux-amd64
RUN chmod 755 /usr/bin/rclone
COPY config/rclone.conf /etc/

USER admin
WORKDIR /home/admin
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
COPY services/ /etc/systemd/system/
COPY build/ build/
