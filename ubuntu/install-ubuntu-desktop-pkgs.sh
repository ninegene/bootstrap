#!/bin/bash
set -e

sudo apt-get update
sudo apt-get install -y gufw
sudo apt-get install -y ttf-mscorefonts-installer
sudo apt-get install -y chromium-browser
sudo apt-get install -y xclip gitg gitk diffuse nautilus-open-terminal

sudo add-apt-repository ppa:synapse-core/ppa
sudo apt-get update
sudo apt-get install synapse
