#!/bin/bash
set -ex

SSH_PORT=22
HTTP_PORT=80
HTTPS_PORT=443

sudo ufw reset

# Deny Incoming and Allow Outgoing
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Enable
sudo ufw allow ${SSH_PORT}
sudo ufw allow ${HTTP_PORT}
#sudo ufw allow ${HTTPS_PORT}

sudo ufw enable
sudo ufw status verbose
