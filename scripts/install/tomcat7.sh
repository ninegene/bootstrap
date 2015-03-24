#!/bin/bash

set -e

BASE_DIR=$(cd "$(dirname "$(readlink -f "$0")")" && pwd)
PKG_URL="http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.55/bin/apache-tomcat-7.0.55.tar.gz"

if [ "$1" = '--force' ] || [ "$1" = "--download-only" ] || [ ! -f ./apache-tomcat-7.0.55.tar.gz ]; then
    curl -O -L ${PKG_URL}

    if [ "$1" = "--download-only" ]; then
        exit 0
    fi
fi

tar xfz apache-tomcat-7.0.55.tar.gz

if [ -L /usr/local/tomcat ]; then
   sudo rm /usr/local/tomcat
fi

if [ -d /usr/local/tomcat ]; then
  sudo mv /usr/local/tomcat /usr/local/tomcat_old
fi

sudo mv apache-tomcat-7.0.55/ /usr/local/
sudo ln -s /usr/local/apache-tomcat-7.0.55 /usr/local/tomcat

sudo cp ${BASE_DIR}/files/tomcat-users.xml /usr/local/tomcat/conf/
sudo cp ${BASE_DIR}/files/context.xml /usr/local/tomcat/conf/
sudo cp ${BASE_DIR}/files/catalina.properties /usr/local/tomcat/conf/
sudo cp ${BASE_DIR}/files/catalina.sh /usr/local/tomcat/bin/
sudo mkdir -p /usr/local/tomcat/shared
sudo chmod -R 755 /usr/local/tomcat
sudo chown -R $(whoami):$(whoami) /usr/local/tomcat

sudo cp ${BASE_DIR}/files/tomcat /etc/init.d/tomcat
sudo chmod 755 /etc/init.d/tomcat
sudo update-rc.d tomcat defaults
