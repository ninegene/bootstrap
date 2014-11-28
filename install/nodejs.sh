#!/bin/bash

curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install -y nodejs

echo """
Hold/unhold a package using apt-mark
$ sudo apt-mark hold nodejs
$ sudo apt-mark unhold nodejs
"""
