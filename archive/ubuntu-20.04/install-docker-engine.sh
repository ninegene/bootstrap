#!/bin/bash
set -eo pipefail

# https://docs.docker.com/engine/install/ubuntu/
set -x

# Set up the repository

sudo apt-get update

sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


# Install Docker Engine

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

echo " 
Verify that Docker Engine is installed correctly by running the hello-world image.
    $ sudo docker run hello-world
"
