#!/bin/sh
set -e

version=$(lsb_release -si)

set +e
lsb_release -a -u > /dev/null 2>&1
lsb_release_exit_code=$?
set -e

if [ "$lsb_release_exit_code" = "0" ]; then
    # Get the upstream version e.g. for Linux Mint
    version=$(lsb_release -a -u 2>&1 | tr '[:upper:]' '[:lower:]' | grep -E 'codename' | cut -d ':' -f 2 | tr -d '[[:space:]]')
fi

rootpw=${1-$version}

mirrorhost="sfo1.mirrors.digitalocean.com"

sudo apt-get update
sudo apt-get install -y python-software-properties
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo add-apt-repository "deb http://$mirrorhost/mariadb/repo/5.5/ubuntu $version main"

sudo apt-get update
echo mysql-server-5.5 mysql-server/root_password password $rootpw | sudo debconf-set-selections
echo mysql-server-5.5 mysql-server/root_password_again password $rootpw | sudo debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server-5.5 mariadb-client-5.5

echo "
For backup/toolkit:
  $ sudo apt-get install -y percona-xtrabackup percona-toolkit

For tuning config:
  $ git clone https://github.com/major/MySQLTuner-perl.git
  $ cd MYSQLTuner-perl
  $ ./mysqltuner.pl

# https://blog.mariadb.org/dotdeb-repository-problems-with-mariadb-5-5-solution/
# Pin the mariadb packages with high priority so if you run into 'unmet dependencies' issue
cat <<EOT > /etc/apt/preferences.d/mariadb.pref
Package: *
Pin: origin $mirrorhost
Pin-Priority: 1009
EOT

Hold/unhold a package for future upgrade using apt-mark if necessary
  $ sudo apt-mark hold mariadb-server-5.5
  $ sudo apt-mark hold mariadb-client-5.5
  $ sudo apt-mark unhold mariadb-server-5.5
  $ sudo apt-mark unhold mariadb-client-5.5

Your root password is '$rootpw'
"
