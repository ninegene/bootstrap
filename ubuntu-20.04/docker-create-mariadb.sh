#!/bin/bash
set -eo pipefail

# https://upcloud.com/community/tutorials/wordpress-with-docker/
#read -p "Enter MySQL root user's password: " MYSQL_ROOT_PASSWORD
#	-e MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" \
#	-e MYSQL_DATABASE=testdb \

set -x
sudo mkdir -p /usr/local/mariadb/{datadir,conf.d}
# https://hub.docker.com/_/mariadb/
sudo docker run \
	-e MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=yes \
	--restart always \
	--name mariadb \
	-v /usr/local/mariadb/datadir:/var/lib/mysql \
	-v /usr/local/mariadb/conf.d:/etc/mysql/conf.d \
	-p 3306:3306 \
	--network wordpress-network \
	--network-alias db \
	-d mariadb:latest

# https://docs.docker.com/engine/reference/commandline/network_connect/#create-a-network-alias-for-a-container
#sudo docker network connect --alias db wordpress-network mariadb


