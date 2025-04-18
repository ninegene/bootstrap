#!/bin/bash
set -eo pipefail

usage() {
    echo "
    Usage:
      $0 <domain>

    Example:
      $0 example.com
"
}

domain=$1

if [[ -z ${domain} ]]; then
    usage
    exit 1
fi

if [[ -f /etc/nginx/sites-available/${domain} ]]; then
    echo "ERROR: file exists: /etc/nginx/sites-available/${domain}"
    exit 1
fi

echo "
server {
	listen 80;
	listen [::]:80;

	server_name ${domain};

	root /var/www/${domain};
	index index.html;

	location / {
		try_files \$uri \$uri/ =404;
	}
}
" | sudo tee /etc/nginx/sites-available/"${domain}" >/dev/null

sudo mkdir -p /var/www/"${domain}"
sudo chown "$UID" /var/www/"${domain}"
touch /var/www/"${domain}"/index.html

echo "
Created virtual host with root directory:
/var/www/${domain}


To enable, run the following:

sudo ln -s /etc/nginx/sites-available/${domain} /etc/nginx/sites-enabled/${domain}
sudo systemctl reload nginx
sudo systemctl status nginx
"


