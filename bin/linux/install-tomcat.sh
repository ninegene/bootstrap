#!/bin/bash

set -e

curl -O http://apache.osuosl.org/tomcat/tomcat-7/v7.0.53/bin/apache-tomcat-7.0.53.tar.gz

sudo mv apache-tomcat-7.0.53 /usr/local/
sudo ln -s /usr/local/apache-tomcat-7.0.53 /usr/local/tomcat

