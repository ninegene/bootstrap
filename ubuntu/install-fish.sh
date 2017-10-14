#!/bin/bash
set -e

(set -x
sudo apt-add-repository ppa:fish-shell/release-2
sudo apt-get update
sudo apt-get install -y fish
mkdir -p ~/.config/fish
)

