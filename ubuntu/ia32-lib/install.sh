#!/bin/bash
set -e

echo "
Installing ia32-libs might remove some packages (e.g. mariadb server and client).
You will have to reinstall packages that get removed during the installation of it.
So make sure you check the list of packages that are going to get removed or installed
before you install ia32-libs ...
"
set -x
sleep 10
sudo dpkg --add-architecture i386
echo "deb http://old-releases.ubuntu.com/ubuntu/ raring main restricted universe multiverse" | sudo tee /etc/apt/sources.list.d/ia32-libs-raring.list
sudo apt-get update
sudo apt-get install ia32-libs

