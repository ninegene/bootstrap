#!/bin/bash
set -e

install_base_pkgs() {
    (set -x;
    sudo apt-get install -y software-properties-common make
    sudo apt-get install -y git vim-nox
    sudo apt-get install -y tree colordiff  # for bash/fish aliases
    sudo apt-get install -y exuberant-ctags # for vim tagbar plugin
    sudo apt-get install -y silversearcher-ag jq python-pip python3-pip
    )
}

install_python_pkgs() {
    (set -x
    sudo pip3 install --upgrade pip
    sudo pip3 install --upgrade jedi   # jedi vim plugin

    sudo pip install --upgrade pip
    sudo pip install --upgrade jedi   # jedi vim plugin
    sudo pip install --upgrade httpie
    )
}

install_base_pkgs
install_python_pkgs
