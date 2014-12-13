#!/bin/bash
set -e

cd /tmp
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u67-b01/jdk-7u67-linux-x64.tar.gz

tar xzf jdk-7u67-linux-x64.tar.gz
sudo mkdir -p /usr/lib/jvm
sudo mv jdk1.7.0_67 /usr/lib/jvm/

if [ -L /usr/lib/jvm/jdk7 ]; then
    echo Removing symlink /usr/lib/jvm/jdk7
    sudo rm /usr/lib/jvm/jdk7
fi

sudo ln -s /usr/lib/jvm/jdk1.7.0_67 /usr/lib/jvm/jdk7

sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk1.7.0_67/bin/jar 1
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.7.0_67/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.7.0_67/bin/javac 1

sudo update-alternatives --set jar /usr/lib/jvm/jdk1.7.0_67/bin/jar
sudo update-alternatives --set java /usr/lib/jvm/jdk1.7.0_67/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/jdk1.7.0_67/bin/javac
