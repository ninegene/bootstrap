#!/bin/sh
set -e

cd /tmp
curl -sSLO https://bootstrap.pypa.io/get-pip.py
python get-pip.py
rm get-pip.py
