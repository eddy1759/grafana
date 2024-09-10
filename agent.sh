#!/bin/bash

# Create directory for Grafana GPG key
sudo mkdir -p /etc/apt/keyrings/

# Download and store Grafana GPG key
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null

# Add Grafana repository
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee /etc/apt/sources.list.d/grafana.list

# Update package list
sudo apt-get update

# Install Grafana Agent
sudo apt-get install -y grafana-agent
