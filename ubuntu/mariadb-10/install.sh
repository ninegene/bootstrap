#!/bin/sh
set -e

dist_version=$(lsb_release -si)

set +e
lsb_release -a -u > /dev/null 2>&1
lsb_release_exit_code=$?
set -e

if [ "$lsb_release_exit_code" = "0" ]; then
    # Get the upstream version e.g. for Linux Mint
    dist_version=$(lsb_release -a -u 2>&1 | tr '[:upper:]' '[:lower:]' | grep -E 'codename' | cut -d ':' -f 2 | tr -d '[[:space:]]')
fi

rootpw=${1-$dist_version}
version=${2-10.1}

mirrorhost="sfo1.mirrors.digitalocean.com"

sudo apt-get update
sudo apt-get install -y python-software-properties
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo add-apt-repository "deb http://$mirrorhost/mariadb/repo/$version/ubuntu $dist_version main"

sudo apt-get update
echo mariadb-server-$version mysql-server/root_password password $rootpw | sudo debconf-set-selections
echo mariadb-server-$version mysql-server/root_password_again password $rootpw | sudo debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server-$version

echo "
For backup/toolkit:
  $ sudo apt-get install -y percona-xtrabackup percona-toolkit

For tuning config:
  $ git clone https://github.com/major/MySQLTuner-perl.git
  $ cd MYSQLTuner-perl
  $ ./mysqltuner.pl

Hold/unhold a package for future upgrade using apt-mark if necessary
  $ sudo apt-mark hold mariadb-server-$version
  $ sudo apt-mark hold mariadb-client-$version
  $ sudo apt-mark unhold mariadb-server-$version
  $ sudo apt-mark unhold mariadb-client-$version

Your root password is '$rootpw'
"
