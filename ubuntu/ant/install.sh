#!/bin/bash
set -e

cd /tmp

curl -O -L http://mirror.sdunix.com/apache/ant/binaries/apache-ant-1.9.5-bin.tar.gz
tar xzvf apache-ant-1.9.5-bin.tar.gz
sudo mv apache-ant-1.9.5 /usr/local/

if [ -L /usr/local/ant ]; then
    echo Removing symlink /usr/local/ant
    sudo rm /usr/local/ant
fi
sudo ln -s /usr/local/apache-ant-1.9.5 /usr/local/ant


if [ -L /usr/bin/ant ]; then
    echo Removing symlink /usr/bin/ant
    sudo rm /usr/bin/ant
fi
sudo ln -s /usr/local/ant/bin/ant /usr/bin/ant

