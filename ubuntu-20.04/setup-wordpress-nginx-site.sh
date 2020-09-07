#!/bin/bash

set -euo pipefail

[[ $UID -eq 0 ]] && { echo "Require to run as non root user!"; } && exit 1

# Based on:
# https://ubuntu.com/tutorials/install-and-configure-wordpress#4-configure-database
# https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-on-ubuntu-18-04

if [[ $# -ne 4 ]]; then
    echo "
    Usage:
    $0 <domain> <dbname> <dbuser> <dbpass>
    "
    #$0 <domain> <dbname> <dbuser> <dbpass> <wpuser> <wppass> <wpemail>
    exit 1
fi

domain=$1
dbname=$2
dbuser=$3
dbpass=$4
# wpuser=$5
# wppass=$6
# wpemail=$7
wp_dir="/var/www/${domain}/wordpress"

if [[ -d ${wp_dir} ]]; then
    echo "${wp_dir} exists!"
    exit 1
fi

set +e
sudo mysql -u root -e "CREATE DATABASE ${dbname} DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;;"

sudo mysql -u root -e "GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER \
    ON ${dbname}.* TO ${dbuser}@localhost \
    IDENTIFIED BY '${dbpass}'; \
    FLUSH PRIVILEGES;"
set -e

sudo mkdir -p ${wp_dir}
sudo mkdir -p ${wp_dir}/wp-content/uploads
sudo chown -R $USER:www-data ${wp_dir}

cd ${wp_dir}

# download wordpress
wp core download

# generate wp-config.php
# https://developer.wordpress.org/cli/commands/config/create/
wp config create --dbname=${dbname} --dbuser=${dbuser} --dbpass=${dbpass} --path=${wp_dir}

# This breaks friendly url/path translation
# https://developer.wordpress.org/cli/commands/core/install/
#wp core install --url="${domain}" \
#    --title="${domain}" \
#    --admin_user="${wpuser}" \
#    --admin_password="${wppass}" \
#    --admin_email="${wpemail}"

#echo "define('FS_METHOD', 'direct');" >> ${wp_dir}/wp-config.php

# Secure permission
ls -lF ${wp_dir}
sudo find ${wp_dir} -type f -exec chmod 640 {} \;
sudo find ${wp_dir} -type d -exec chmod 750 {} \;
# https://www.nginx.com/blog/installing-wordpress-with-nginx-unit/
sudo chown -R $USER:www-data ${wp_dir}
sudo chmod g+w ${wp_dir}/wp-content
sudo find ${wp_dir} -type d -exec chmod g+s {} \;
sudo chmod -R g+w ${wp_dir}/wp-content/themes
sudo chmod -R g+w ${wp_dir}/wp-content/plugins
sudo chmod -R g+w ${wp_dir}/wp-content/uploads
sudo chmod 640 ${wp_dir}/wp-config.php

if [[ -f /etc/nginx/sites-available/${domain}.conf ]]; then
    echo "File exists: /etc/nginx/sites-available/${domain}.conf"
    read -p "Overwrite? [Y/n]" confirm
    if [[ ${confirm} == "n" ]]; then
        exit 1
    fi
fi

echo "
server {
    listen 80;
    listen [::]:80;

    server_name    ${domain};

    root           ${wp_dir};
    index          index.php index.html;

    location / {
        try_files \$uri \$uri/ /index.php;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_pass unix:/run/php/php7.4-fpm.sock;
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
