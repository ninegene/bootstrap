#!/bin/sh
set -e

version=${1-"2.11.8"}
filename=scala-${version}

set -x
cd /tmp/
wget -O ${filename}.tgz http://www.scala-lang.org/files/archive/${filename}.tgz
tar xzf ${filename}.tgz
[[ ! -d /usr/local/${filename} ]] && sudo mv ${filename} /usr/local/
sudo ln -sf /usr/local/${filename} /usr/local/scala

set +e
sudo update-alternatives --install /usr/bin/fsc fsc /usr/local/scala/bin/fsc 1
sudo update-alternatives --install /usr/bin/scala scala /usr/local/scala/bin/scala 1
sudo update-alternatives --install /usr/bin/scalac scalac /usr/local/scala/bin/scalac 1
sudo update-alternatives --install /usr/bin/scaladoc scaladoc /usr/local/scala/bin/scaladoc 1
sudo update-alternatives --install /usr/bin/scalap scalap /usr/local/scala/bin/scalap 1
set -e

sudo update-alternatives --set fsc /usr/local/scala/bin/fsc
sudo update-alternatives --set scala /usr/local/scala/bin/scala
sudo update-alternatives --set scalac /usr/local/scala/bin/scalac
sudo update-alternatives --set scaladoc /usr/local/scala/bin/scaladoc
sudo update-alternatives --set scalap /usr/local/scala/bin/scalap

scala -version

