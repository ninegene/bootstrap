#!/bin/bash

wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.tar.gz
tar xzf jdk-7u51-linux-x64.tar.gz
sudo mkdir -p /usr/lib/jvm
sudo mv jdk1.7.0_51 /usr/lib/jvm/
sudo ln -s /usr/lib/jvm/jdk1.7.0_51 /usr/lib/jvm/jdk7

sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk1.7.0_51/bin/jar 1
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.7.0_51/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.7.0_51/bin/javac 1

sudo update-alternatives --set jar /usr/lib/jvm/jdk1.7.0_51/bin/jar
sudo update-alternatives --set java /usr/lib/jvm/jdk1.7.0_51/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/jdk1.7.0_51/bin/javac
