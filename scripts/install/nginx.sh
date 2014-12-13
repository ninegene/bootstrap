#!/bin/bash
set -e

sudo apt-get update
sudo add-apt-repository ppa:nginx/stable
sudo apt-get update
sudo apt-get install -V nginx

echo """
$ sudo service nginx [stop|start|reload|restart]

Hold/unhold a package using apt-mark
$ sudo apt-mark hold nginx
$ sudo apt-mark unhold nginx

Help:
$ nginx -h

Test config:
$ sudo nginx -t

Test Install:
$ curl http://$(hostname -I)

Config:
$ sudo vi /etc/nginx/nginx.conf
server_tokens on;

Reading:
https://www.linode.com/docs/websites/nginx/basic-nginx-configuration
"""
