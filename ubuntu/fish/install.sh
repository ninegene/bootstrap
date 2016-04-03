#!/bin/sh

sudo apt-add-repository ppa:fish-shell/release-2
sudo apt-get update
sudo apt-get install -y fish

mkdir -p ~/.config/fish

echo """
Execute the follownt to use fish as your default shell:
$ chsh -s /usr/bin/fish
"""
