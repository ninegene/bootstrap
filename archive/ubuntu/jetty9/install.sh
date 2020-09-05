#!/bin/sh
set -e

filename=jetty-distribution-9.2.3.v20140905

wget -O $filename.tar.gz "http://eclipse.org/downloads/download.php?file=/jetty/stable-9/dist/$filename.tar.gz&r=1"
tar xzf $filename.tar.gz
sudo mv $filename /opt/
sudo ln -s /opt/$filename /opt/jetty

sudo useradd jetty -U -s /bin/false
sudo chown -R jetty:jetty /opt/$filename
sudo chown -R jetty:jetty /opt/jetty
sudo cp /opt/jetty/bin/jetty.sh /etc/init.d/jetty

echo """
JAVA=/usr/bin/java
NO_START=0  # Start on boot
JETTY_HOST=0.0.0.0
JETTY_ARGS=jetty.port=8085
JETTY_USER=jetty
JETTY_HOME=/opt/jetty
""" | sudo tee /etc/default/jetty

# verify config
sudo service jetty status

# start jetty on boot
sudo update-rc.d jetty defaults

sudo service jetty start
