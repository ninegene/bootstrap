#!/bin/bash

set -eo pipefail

domain=$1

set -u

[[ $UID -eq 0 ]] && { echo "Require to run as non root user!"; } && exit 1

if [[ -f /etc/nginx/sites-available/${domain}.conf ]]; then
    echo "File exists: /etc/nginx/sites-available/${domain}.conf"
    read -p "Overwrite? [Y/n]" confirm
    if [[ ${confirm} == "n" ]]; then
        exit 1
    fi
fi

sudo mkdir -p /var/www/${domain}/public
sudo chown -R $USER:$USER /var/www/${domain}/public

echo "
server {
    listen 80;
    listen [::]:80;

    server_name    ${domain};

    root           /var/www/${domain}/public;
    index          index.php index.html;

    location / {
        try_files \$uri \$uri/ =404
        autoindex on;
    }

    access_log /var/log/nginx/${domain}.access.log;
    error_log /var/log/nginx/${domain}.error.log warn;
}
" | sudo tee /etc/nginx/sites-available/${domain}.conf

set -x
sudo ln -sf /etc/nginx/sites-available/${domain}.conf /etc/nginx/sites-enabled/${domain}.conf

# Check syntax
sudo nginx -t
sudo systemctl restart nginx

# Generalte Cert
sudo certbot -d ${domain} --agree-tos -m certbot@ninegene.com --nginx --redirect -n
sudo systemctl reload nginx
