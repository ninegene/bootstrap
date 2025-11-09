#!/bin/bash
set -eo pipefail

#read -p "SITE_NAME: " SITE_NAME
#read -p "DB_NAME: " DB_NAME
SITE_NAME=ninegene.com
DB_NAME=wordpressdb
DB_HOST=db
DB_USER=wordpress
DB_PASS=wordpress

# https://hub.docker.com/_/wordpress/
set -x

sudo mkdir -p /usr/local/wordpress/$SITE_NAME/{html,php-conf.d}

sudo docker run \
	--name wordpress \
	--restart always \
	-e WORDPRESS_DB_HOST=$DB_HOST \
        -e WORDPRESS_DB_USER=$DB_USER \
        -e WORDPRESS_DB_PASSWORD=$DB_PASS \
        -e WORDPRESS_DB_NAME=$DB_NAME \
	-p 8080:80 \
	-v /usr/local/wordpress/$SITE_NAME/html:/var/www/html \
	-v /usr/local/wordpress/$SITE_NAME/php-conf.d:$PHP_INI_DIR/conf.d \
	--network wordpress-network \
	-d wordpress
