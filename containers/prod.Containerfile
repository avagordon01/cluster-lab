FROM base:latest
USER root
RUN tuned-adm profile network-latency
CMD ["/sbin/init"]
