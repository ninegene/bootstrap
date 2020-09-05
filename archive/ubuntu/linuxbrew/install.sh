#!/bin/bash
set -e

echo "Running apt-get update ..."
sudo apt-get update >/dev/null


# Base on: https://github.com/Linuxbrew/brew
set -x
sudo apt-get install build-essential curl git python-setuptools ruby

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"

if ! grep -q 'export PATH="$HOME/.linuxbrew/bin:$PATH"' ~/.profile 2>/dev/null; then
    echo 'export PATH="$HOME/.linuxbrew/bin:$PATH"' >> ~/.profile
    echo 'export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"' >> ~/.profile
    echo 'export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"' >> ~/.profile
fi
