#!/bin/bash

# Based on: http://askubuntu.com/questions/113984/is-logitechs-unifying-receiver-supported

CURDIR=$(dirname "$(readlink -f "$0")")

# cd ${CURDIR}
# sudo apt-get update
# sudo apt-get install git gcc
# git clone https://git.lekensteyn.nl/ltunify.git
# cd ltunify
# make install-home

VERSION=$(lsb_release -sc)
echo "deb http://ppa.launchpad.net/daniel.pavel/solaar/ubuntu ${VERSION} main" | sudo tee /etc/apt/sources.list.d/daniel.pavel-solaar-${VERSION}.list
sudo apt-get update
sudo apt-get install solaar
