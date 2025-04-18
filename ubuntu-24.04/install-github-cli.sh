#!/bin/bash
set -eo pipefail

if command -v gh >/dev/null 2>&1; then
    echo "GitHub CLI is already installed!"
    gh --version
    exit
fi

# Based on: https://github.com/cli/cli/blob/trunk/docs/install_linux.md

type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)
sudo mkdir -p -m 755 /etc/apt/keyrings
out=$(mktemp)
wget -nv -O"$out" https://cli.github.com/packages/githubcli-archive-keyring.gpg
sudo cat "$out" | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh -y
