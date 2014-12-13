#!/bin/bash
set -e

function usage {
    echo "Usage: $(basename $0) [12.04|14.04] [root_password]"
}

if [ -z "$1" ] || [ -z "$2" ]; then
    usage
    exit 1
fi

version=${1}
pass=${2}

if [ "$version" = '12.04' ]; then
    version='precise'
elif [ "$version" = '14.04' ]; then
    version='trusty'
else
    usage
    exit 2
fi

mirrorhost="sfo1.mirrors.digitalocean.com"

sudo apt-get update
sudo apt-get install -y python-software-properties
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo add-apt-repository "deb http://$mirrorhost/mariadb/repo/5.5/ubuntu $version main"

# pin the mariadb packages with high priority so that we don't have "unmet dependencies" issue
# https://blog.mariadb.org/dotdeb-repository-problems-with-mariadb-5-5-solution/
cat <<EOT > /etc/apt/preferences.d/mariadb.pref
Package: *
Pin: origin $mirrorhost
Pin-Priority: 1009
EOT

sudo apt-get update
echo mysql-server-5.5 mysql-server/root_password password $pass | sudo debconf-set-selections
echo mysql-server-5.5 mysql-server/root_password_again password $pass | sudo debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server-5.5 mariadb-client-5.5

echo "
For backup/toolkit:
  $ sudo apt-get install -y percona-xtrabackup percona-toolkit

For tuning config:
  $ git clone https://github.com/major/MySQLTuner-perl.git
  $ cd MYSQLTuner-perl
  $ ./mysqltuner.pl

Hold/unhold a package for future upgrade using apt-mark if necessary
  $ sudo apt-mark hold mariadb-server-5.5
  $ sudo apt-mark hold mariadb-client-5.5
  $ sudo apt-mark unhold mariadb-server-5.5
  $ sudo apt-mark unhold mariadb-client-5.5
"
