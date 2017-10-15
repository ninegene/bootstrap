#!/bin/bash
set -e

(set -x;
sudo apt-get install -y software-properties-common make
sudo apt-get install -y git vim-nox
sudo apt-get install -y tree colordiff  # for bash/fish aliases
sudo apt-get install -y exuberant-ctags # for vim tagbar plugin
sudo apt-get install -y silversearcher-ag jq
)
