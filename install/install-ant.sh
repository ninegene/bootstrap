#!/bin/bash

set -e

curl -O -L http://mirror.sdunix.com/apache/ant/binaries/apache-ant-1.9.4-bin.tar.gz
tar xzvf apache-ant-1.9.4-bin.tar.gz
sudo mv apache-ant-1.9.4 /usr/local/
sudo ln -s /usr/local/apache-ant-1.9.4 /usr/local/ant
sudo ln -s /usr/local/ant/bin/ant /usr/bin/ant

