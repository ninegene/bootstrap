#!/bin/bash
# Based on https://munin.readthedocs.org/en/latest/installation/install.html

# sudo apt-get install -y munin munin-node munin-plugins-extra
# Install from source for latest stable version
curl -O -L http://downloads.munin-monitoring.org/munin/stable/2.0.21/munin-2.0.21.tar.gz
tar xzvf munin-2.0.21.tar.gz
sudo useradd -s /bin/false -r munin -U
sudo apt-get install -y htmldoc html2text libjson-rpc-perl
sudo apt-get install -y make
sudo make

# install master, node, and everything else
sudo make install

# to install only node
#make install-common-prime install-node-prime install-plugins-prime

sudo sed -i 's/^#dbdir/dbdir/' /etc/opt/munin/munin.conf
sudo sed -i 's/^#htmldir/htmldir/' /etc/opt/munin/munin.conf
sudo sed -i 's/^#logdir/logdir/' /etc/opt/munin/munin.conf
sudo sed -i 's/^#rundir/rundir/' /etc/opt/munin/munin.conf

