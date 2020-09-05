#!/bin/sh
set -e

jdk18x="jdk1.8.0_102"
jdk8u="jdk-8u102"
dir="8u102-b14"
# https://www.oracle.com/webfolder/s/digest/8u102checksum.html
md5checksum="bac58dcec9bb85859810a2a6acba740b"

jdktzfile="$jdk8u-linux-x64.tar.gz"
url="http://download.oracle.com/otn-pub/java/jdk/$dir/$jdktzfile"

cd /tmp
echo "$md5checksum $jdktzfile" > /tmp/jdk8md5

if [ ! -f $jdktzfile ]; then
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" $url
fi

md5sum -c /tmp/jdk8md5

tar xzf $jdktzfile
sudo mkdir -p /usr/lib/jvm
sudo mv $jdk18x /usr/lib/jvm/

if [ -L /usr/lib/jvm/jdk8 ]; then
    echo Removing symlink /usr/lib/jvm/jdk8
    sudo rm /usr/lib/jvm/jdk8
fi

sudo ln -s /usr/lib/jvm/$jdk18x /usr/lib/jvm/jdk8

sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/$jdk18x/bin/jar 8
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/$jdk18x/bin/java 8
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/$jdk18x/bin/javac 8
sudo update-alternatives --install /usr/bin/keytool keytool /usr/lib/jvm/$jdk18x/bin/keytool 8

sudo update-alternatives --set jar /usr/lib/jvm/$jdk18x/bin/jar
sudo update-alternatives --set java /usr/lib/jvm/$jdk18x/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/$jdk18x/bin/javac
sudo update-alternatives --set keytool /usr/lib/jvm/$jdk18x/bin/keytool
