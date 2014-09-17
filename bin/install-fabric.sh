#!/bin/bash

set -e

cd /tmp
curl -O https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py

sudo pip install fabric
