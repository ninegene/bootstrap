#!/bin/sh
set -e

jdk17x="jdk1.7.0_79"
jdk7u="jdk-7u79"
dir="7u79-b15"

jdktzfile="$jdk7u-linux-x64.tar.gz"
url="http://download.oracle.com/otn-pub/java/jdk/$dir/$jdktzfile"

cd /tmp
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" $url

tar xzf $jdktzfile
sudo mkdir -p /usr/lib/jvm
sudo mv $jdk17x /usr/lib/jvm/

if [ -L /usr/lib/jvm/jdk7 ]; then
    echo Removing symlink /usr/lib/jvm/jdk7
    sudo rm /usr/lib/jvm/jdk7
fi

sudo ln -s /usr/lib/jvm/$jdk17x /usr/lib/jvm/jdk7

sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/$jdk17x/bin/jar 7
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/$jdk17x/bin/java 7
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/$jdk17x/bin/javac 7
sudo update-alternatives --install /usr/bin/keytool keytool /usr/lib/jvm/$jdk17x/bin/keytool 7

sudo update-alternatives --set jar /usr/lib/jvm/$jdk17x/bin/jar
sudo update-alternatives --set java /usr/lib/jvm/$jdk17x/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/$jdk17x/bin/javac
sudo update-alternatives --set keytool /usr/lib/jvm/$jdk17x/bin/keytool
