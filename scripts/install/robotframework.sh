#!/bin/bash
set -e

sudo pip install robotframework

# IDE
sudo pip install robotframework-ride
sudo apt-get install python-wxgtk2.8

echo "
Run Roboframework IDE:
    $ ride.py
"
