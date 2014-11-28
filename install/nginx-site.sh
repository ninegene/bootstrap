#!/bin/bash
set -e

if [ -z "$1" ]; then
    echo "Usage: $(basename $0) mydomain.com"
    exit 1
fi

DOMAIN_NAME=$1

sudo mkdir -p /var/www/$DOMAIN_NAME/html
sudo chown -R $USER:$USER /var/www/$DOMAIN_NAME
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/$DOMAIN_NAME

# change to "listen 80;"
sudo sed -i "s/listen 80 default_server;/listen 80;/g" /etc/nginx/sites-available/$DOMAIN_NAME

# change to "listen [::]:80;"
#	listen [::]:80 default_server ipv6only=on;
sudo sed -i "s/listen \[::\]:80 default_server ipv6only=on;/listen [::]:80;/g" /etc/nginx/sites-available/$DOMAIN_NAME

# change to "root /var/www/$DOMAIN_NAME
sudo sed -i "s/root \/usr\/share\/nginx\/html/root \/var\/www\/$DOMAIN_NAME\/html/g" /etc/nginx/sites-available/$DOMAIN_NAME

# change to "server_name $DOMAIN_NAME"
sudo sed -i "s/server_name localhost;/server_name $DOMAIN_NAME;/g" /etc/nginx/sites-available/$DOMAIN_NAME

sudo rm -f /etc/nginx/sites-enabled/$DOMAIN_NAME
sudo ln -s /etc/nginx/sites-available/$DOMAIN_NAME /etc/nginx/sites-enabled/
sudo nginx -t

sudo rm -f /etc/nginx/sites-enabled/default
sudo service nginx restart
