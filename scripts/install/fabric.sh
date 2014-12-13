#!/bin/bash
set -e

cd /tmp
curl -O https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
rm get-pip.py
cd -

sudo pip install --upgrade fabric
