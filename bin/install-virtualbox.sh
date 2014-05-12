#!/bin/bash
# Based on instruction on:
# https://www.virtualbox.org/wiki/Linux_Downloads
# http://www.howopensource.com/2013/04/install-virtualbox-ubuntu-ppa/
# http://www.n00bsonubuntu.net/content/install-virtualbox-ubuntu-14-04/

set -e

# Needed for Ubuntu 14.04
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian saucy contrib" >> /etc/apt/sources.list.d/virtualbox.list'

wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y virtualbox-4.3
sudo apt-get install -y dkms
sudo adduser $(whoami) vboxusers

echo "
Download extension pack

Check the verion you want at http://download.virtualbox.org/virtualbox/
e.g.
wget http://download.virtualbox.org/virtualbox/4.3.10/Oracle_VM_VirtualBox_Extension_Pack-4.3.10-93012.vbox-extpack

To Install the extension pack open your Home folder and double click on the
Oracle_VM_VirtualBox_Extension_Pack-4.3.10-93012.vbox-extpack file
and install it with VirtualBox.

"

echo "
What to do when experiencing The following signatures were invalid: BADSIG ...
when refreshing the packages from the repository?

$ sudo -s -H
$ apt-get clean
$ rm /var/lib/apt/lists/*
$ rm /var/lib/apt/lists/partial/*
$ apt-get clean
$ apt-get update
"
