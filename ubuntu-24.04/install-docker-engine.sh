#!/bin/bash
set -eo pipefail

# Based on: https://docs.docker.com/engine/install/ubuntu/
(
    set -x
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    # shellcheck disable=SC1091
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    docker --version

    # Post install stuffs
    # https://docs.docker.com/engine/install/linux-postinstall/

    # Run "docker" command without sudo
    getent group docker >/dev/null || sudo groupadd docker
    sudo usermod -aG docker "$USER"
    sudo mkdir -p /home/"$USER"/.docker
    sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
    sudo chmod g+rwx "$HOME/.docker" -R

    # Start on boot
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service

    # https://docs.docker.com/engine/logging/drivers/json-file/
    # https://docs.docker.com/engine/logging/drivers/local/

    [[ -f /etc/docker/daemon.json ]] || echo '{
  "log-driver": "local",
  "log-opts": {
    "max-size": "50m"
  }
}' | sudo tee /etc/docker/daemon.json
)

echo "
Using log-driver: $(jq -r '.["log-driver"]' < /etc/docker/daemon.json)

About container logs, see:
  https://docs.docker.com/engine/logging/
  https://docs.docker.com/engine/logging/drivers/local/

Verify that the installation is successful by running the hello-world image:
  sudo docker run hello-world

This command downloads a test image and runs it in a container.
When the container runs, it prints a confirmation message and exits.
"
