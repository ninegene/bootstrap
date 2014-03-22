#!/bin/bash

sudo apt-add-repository ppa:fish-shell/release-2
sudo apt-get update
sudo apt-get install fish

# chsh -s /usr/bin/fish
mkdir -p ~/.config/fish
