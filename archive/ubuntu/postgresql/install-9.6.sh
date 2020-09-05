#!/bin/bash
set -e

sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update

sudo apt-get install -y postgresql-9.6 postgresql-contrib-9.6
