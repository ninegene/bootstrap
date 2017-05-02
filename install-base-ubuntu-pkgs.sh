#!/bin/bash
set -e

(set -x;
sudo apt-get install -y git vim-nox ntp
sudo apt-get install -y tree colordiff  # for bash/fish aliases
sudo apt-get install -y exuberant-ctags # for vim tagbar plugin
sudo apt-get install -y silversearcher-ag

# Install fish shell
sudo apt-add-repository ppa:fish-shell/release-2
sudo apt-get update
sudo apt-get install -y fish
mkdir -p ~/.config/fish
)

set +e
echo "Setting fish as default shell ..."
(set -x; chsh -s /usr/bin/fish)
echo "Logout and log back in to take effect."
sleep 3
set -e
