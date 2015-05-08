#!/bin/bash
set -e

source /etc/lsb-release && echo "deb http://download.rethinkdb.com/apt $DISTRIB_CODENAME main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list
wget -qO- http://download.rethinkdb.com/apt/pubkey.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install rethinkdb

set -x
curl -SsL https://raw.githubusercontent.com/rethinkdb/rethinkdb/next/packaging/assets/config/default.conf.sample > /tmp/default.conf.sample
sudo cp /tmp/default.conf.sample /etc/rethinkdb/
sudo cp /etc/rethinkdb/default.conf.sample /etc/rethinkdb/instances.d/instance1.conf
sudo service rethinkdb start
set +x

echo "
Based on:
  http://www.rethinkdb.com/docs/install/ubuntu/
  http://www.rethinkdb.com/docs/start-on-startup/
"
