#!/bin/sh
set -e

CURDIR=$(dirname "$(readlink -f "$0")")

$CURDIR/../python-pip/install.sh
sudo pip install --upgrade fabric
