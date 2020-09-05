#!/bin/sh
set -e

# Based on instruction on:
# https://www.virtualbox.org/wiki/Linux_Downloads
# http://www.n00bsonubuntu.net/content/install-virtualbox-ubuntu-14-04/

dist_version=$(lsb_release -sc)

set +e
lsb_release -a -u > /dev/null 2>&1
lsb_release_exit_code=$?
set -e

if [ "$lsb_release_exit_code" = "0" ]; then
    # Get the upstream version e.g. for Linux Mint
    dist_version=$(lsb_release -a -u 2>&1 | tr '[:upper:]' '[:lower:]' | grep -E 'codename' | cut -d ':' -f 2 | tr -d '[[:space:]]')
fi

sudo sh -c "echo 'deb http://download.virtualbox.org/virtualbox/debian $dist_version contrib' > /etc/apt/sources.list.d/virtualbox.list"

wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y virtualbox-5.0
sudo apt-get install -y dkms
# sudo adduser $(whoami) vboxusers

echo "
Download extension pack

Check the verion you want at http://download.virtualbox.org/virtualbox/
e.g.
cd /tmp
wget http://download.virtualbox.org/virtualbox/5.0.4/Oracle_VM_VirtualBox_Extension_Pack-5.0.4.vbox-extpack

To Install the extension pack open the folder downloaded and double click on the
Oracle_VM_VirtualBox_Extension_Pack-4.3.10-93012.vbox-extpack file
and install it with VirtualBox.

What to do when experiencing The following signatures were invalid: BADSIG ...
when refreshing the packages from the repository?

$ sudo -s -H
$ apt-get clean
$ rm /var/lib/apt/lists/*
$ rm /var/lib/apt/lists/partial/*
$ apt-get clean
$ apt-get update
"
