FROM grafana/agent:latest
COPY grafana.yml /etc/agent/config.yml
CMD ["agent", "-config.file=/etc/agent/config.yml"]
