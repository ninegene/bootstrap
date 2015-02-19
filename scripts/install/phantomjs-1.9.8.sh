#!/bin/bash
set -e

# Based on: https://gist.github.com/julionc/7476620

sudo apt-get update
sudo apt-get install -y build-essential chrpath libssl-dev libxft-dev
sudo apt-get install -y libfreetype6 libfreetype6-dev
sudo apt-get install -y libfontconfig1 libfontconfig1-dev
sudo apt-get install -y msttcorefonts

cd /tmp
phantomjs="phantomjs-1.9.8-linux-x86_64"
compressed_file="${phantomjs}.tar.bz2"
wget https://bitbucket.org/ariya/phantomjs/downloads/${compressed_file}
sudo tar xvjf ${compressed_file}

sudo mv ${phantomjs} /usr/local/
cd /usr/local

sudo ln -sf /usr/local/${phantomjs}/bin/phantomjs /usr/local/bin/phantomjs

echo "
phantomjs is installed in /usr/local/bin/phantomjs

$ phantomjs --version
"
phantomjs --version
