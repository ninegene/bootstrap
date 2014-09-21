#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo "Usage: $(basename $0) [root_password]"
    exit 1
fi

pass=${1}

sudo apt-get update
sudo apt-get install -y python-software-properties
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo add-apt-repository 'deb http://sfo1.mirrors.digitalocean.com/mariadb/repo/10.0/ubuntu trusty main'
sudo apt-get update
echo mariadb-server-10.0 mysql-server/root_password password $pass | sudo debconf-set-selections

echo mariadb-server-10.0 mysql-server/root_password_again password $pass | sudo debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server

sudo apt-get install -y percona-xtrabackup percona-toolkit

echo "
For tuning config:
  $ git clone https://github.com/major/MySQLTuner-perl.git
  $ cd MYSQLTuner-perl
  $ ./mysqltuner.pl
"
