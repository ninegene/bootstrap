#!/bin/bash
set -e

echo "deb http://deb.goaccess.io/ $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/goaccess.list
wget -O - https://deb.goaccess.io/gnugpg.key | sudo apt-key add -

set -x
sudo apt-get update
sudo apt-get install -V goaccess

