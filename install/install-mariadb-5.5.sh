#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo "Usage: ./install-mariadb-5.5.sh <root_password>"
    exit 0
fi

pass=${1}

sudo apt-get update
sudo apt-get install -y python-software-properties
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
sudo add-apt-repository 'deb http://ftp.osuosl.org/pub/mariadb/repo/5.5/ubuntu quantal main'
sudo apt-get update
echo mysql-server-5.5 mysql-server/root_password password $pass | sudo debconf-set-selections
echo mysql-server-5.5 mysql-server/root_password_again password $pass | sudo debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server-5.5

sudo apt-get install -y percona-xtrabackup percona-toolkit

echo "
For tuning config:
  $ git clone https://github.com/major/MySQLTuner-perl.git
  $ cd MYSQLTuner-perl
  $ ./mysqltuner.pl
"
