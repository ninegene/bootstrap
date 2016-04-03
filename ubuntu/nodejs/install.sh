#!/bin/sh

# See https://github.com/nodesource/distributions#installation-instructions

if [ -z "$1" ]; then
    curl -sL https://deb.nodesource.com/setup | sudo -E bash -
else
    curl -sL https://deb.nodesource.com/setup_$1 | sudo -E bash -
fi

sudo apt-get install -y nodejs

echo """
Hold/unhold a package using apt-mark
$ sudo apt-mark hold nodejs
$ sudo apt-mark unhold nodejs
"""
