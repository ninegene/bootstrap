#!/bin/sh
set -e

CURDIR=$(dirname "$(readlink -f "$0")")

$CURDIR/python-pip/install.sh
sudo pip install --upgrade robotframework

# IDE
sudo pip install --upgrade robotframework-ride
sudo apt-get install python-wxgtk2.8

echo "
Run Roboframework IDE:
    $ ride.py
"
