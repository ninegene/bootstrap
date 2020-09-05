#!/bin/bash
set -e

# usage() {
#     echo "Usage: $(basename $0) [root_password]"
# }

# if [ -z "$1" ]; then
#     usage
#     exit 1
# fi

rootpw=$1
version=${2-10.1}
codename=$(lsb_release -sc)
mirrorhost="sfo1.mirrors.digitalocean.com"

# For linux mint
set +e
lsb_release -a -u > /dev/null 2>&1
lsb_release_exit_code=$?
set -e
if [ "$lsb_release_exit_code" = "0" ]; then
    # Get the upstream version for Linux Mint
    codename=$(lsb_release -a -u 2>&1 | tr '[:upper:]' '[:lower:]' | grep -E 'codename' | cut -d ':' -f 2 | tr -d '[[:space:]]')
fi

echo -n "Running apt-get update... "
sudo apt-get update > /dev/null
echo "Done"
(set -x;
sudo apt-get install software-properties-common
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo add-apt-repository "deb [arch=amd64,i386] http://$mirrorhost/mariadb/repo/$version/ubuntu $codename main"
)

# pin the mariadb packages with high priority so that we don't have "unmet dependencies" issue
# https://blog.mariadb.org/dotdeb-repository-problems-with-mariadb-5-5-solution/
sudo sh -c "cat <<EOT > /etc/apt/preferences.d/mariadb.pref
Package: *
Pin: origin $mirrorhost
Pin-Priority: 2000
EOT"

echo -n "Running apt-get update... "
sudo apt-get update > /dev/null
echo "Done"
echo mysql-server mysql-server/root_password password $rootpw | sudo debconf-set-selections
echo mysql-server mysql-server/root_password_again password $rootpw | sudo debconf-set-selections
(set -x;
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -V mariadb-server mariadb-client
)

echo "
For backup/toolkit:
  $ sudo apt-get install -y percona-xtrabackup percona-toolkit

For tuning config:
  $ git clone https://github.com/major/MySQLTuner-perl.git
  $ cd MYSQLTuner-perl
  $ ./mysqltuner.pl

Hold/unhold a package for future upgrade using apt-mark if necessary
  $ sudo apt-mark hold mariadb-server
  $ sudo apt-mark hold mariadb-client
  $ sudo apt-mark unhold mariadb-server
  $ sudo apt-mark unhold mariadb-client

"

mysql --version

if [[ $rootpw ]]; then
    echo "Your root password is $rootpw"
else
    echo "No root password is set! Set root password if necessary:"
    echo "
    $ mysql -u root
    mysql> UPDATE mysql.user SET Password = PASSWORD('newpwd')
        ->     WHERE User = 'root';
    mysql> FLUSH PRIVILEGES;
    "
fi
