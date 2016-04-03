#!/bin/bash
set -e

cd /tmp

curl -O -L http://archive.apache.org/dist/ant/ivy/2.4.0/apache-ivy-2.4.0-bin.tar.gz
tar xzf apache-ivy-2.4.0-bin.tar.gz
sudo cp apache-ivy-2.4.0/ivy-2.4.0.jar /usr/local/ant/lib
sudo mv apache-ivy-2.4.0 /usr/local/
