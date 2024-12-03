#!/bin/bash

set -ex

# Redirect all output to a log file for debugging
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Install dnf if it's not available
sudo yum install -y dnf

# Update system packages
sudo dnf update -y

# Install PostgreSQL
sudo dnf install -y postgresql16.x86_64 postgresql16-server

# Initialise the PostgreSQL database
sudo /usr/pgsql-16/bin/postgresql-16-setup initdb

# Start and enable PostgreSQL service
sudo systemctl start postgresql-16
sudo systemctl enable postgresql-16
