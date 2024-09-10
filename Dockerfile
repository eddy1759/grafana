# Use a base Ubuntu image
FROM ubuntu:20.04

# Install necessary dependencies
RUN apt-get update && apt-get install -y wget

# Download and install Grafana Agent
RUN wget -q -O /tmp/grafana-agent.deb https://github.com/grafana/agent/releases/latest/download/grafana-agent-amd64.deb
RUN dpkg -i /tmp/grafana-agent.deb

# Create a directory for the configuration file
RUN mkdir -p /etc/grafana-agent

# Copy your configuration file into the image if it exists, otherwise create a default one
COPY agent-config.yaml /etc/grafana-agent/agent-config.yaml || echo "server:\n  log_level: info" > /etc/grafana-agent/agent-config.yaml

# Set the correct permissions
RUN chmod 755 /usr/bin/grafana-agent
RUN chown -R nobody:nogroup /etc/grafana-agent

# Switch to non-root user
USER nobody

# Set the entrypoint
ENTRYPOINT ["/usr/bin/grafana-agent"]
CMD ["--config.file=/etc/grafana-agent/agent-config.yaml"]
