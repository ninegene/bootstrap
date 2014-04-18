#!/bin/bash

set -e

curl -O http://mirror.sdunix.com/apache//ant/binaries/apache-ant-1.9.3-bin.tar.gz
tar xvf apache-ant-1.9.3-bin.tar.gz
sudo mv apache-ant-1.9.3 /usr/local/
sudo ln -s /usr/local/apache-ant-1.9.3 /usr/local/ant
sudo ln -s /usr/local/ant/bin/ant /usr/bin/ant

