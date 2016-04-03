#!/bin/sh
set -e

sudo apt-get update

# See http://phantomjs.org/build.html
sudo apt-get install -y build-essential g++ flex bison gperf ruby perl \
  libsqlite3-dev libfontconfig1-dev libicu-dev libfreetype6 libssl-dev \
  libpng-dev libjpeg-dev python libx11-dev libxext-dev
sudo apt-get install -y msttcorefonts

mkdir ~/opt/phantomjs
git clone git://github.com/ariya/phantomjs.git
cd phantomjs
git checkout 2.0
./build.sh

ln -sf ~/opt/phantomjs/bin/phantomjs ~/bin/phantomjs

# Based on: https://gist.github.com/julionc/7476620
# sudo apt-get install -y build-essential chrpath libssl-dev libxft-dev
# sudo apt-get install -y libfreetype6 libfreetype6-dev
# sudo apt-get install -y libfontconfig1 libfontconfig1-dev
# sudo apt-get install -y msttcorefonts

# cd /tmp
# phantomjs="phantomjs-1.9.8-linux-x86_64"
# compressed_file="${phantomjs}.tar.bz2"
# wget https://bitbucket.org/ariya/phantomjs/downloads/${compressed_file}
# sudo tar xvjf ${compressed_file}

# sudo mv ${phantomjs} /usr/local/
# cd /usr/local

# sudo ln -sf /usr/local/${phantomjs}/bin/phantomjs /usr/local/bin/phantomjs

echo "
phantomjs is installed in /usr/local/bin/phantomjs

$ phantomjs --version
"
phantomjs --version
