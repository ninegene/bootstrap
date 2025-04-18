#!/bin/bash
set -eo pipefail

# Based on:
#     https://ubuntu.com/server/docs/how-to-install-nginx

install_nginx() {
    (
        set -x
        sudo apt update
        sudo apt install nginx
    )
}

list_all_avaliable_modules() {
    echo -e "\nAll available modules:"
    [[ $DEBIAN_FRONTEND == "noninteractive" ]] || sleep 1
    nginx -V 2>&1 | tr -- - '\n' | grep '.*_module'
}

nginx_status() {
    echo -e "\nCheck nginx status:"
    [[ $DEBIAN_FRONTEND == "noninteractive" ]] || sleep 1
    (
        set -x
        sudo systemctl status nginx
    )
}

about_nginx() {
    echo -e "\nNginx info:"
    [[ $DEBIAN_FRONTEND == "noninteractive" ]] || sleep 1
    echo '
    Default config file:
        /etc/nginx/sites-enabled/default

    For HTTPS certificate, see:
        https://certbot.eff.org/instructions?ws=nginx&os=pip

    Check config file syntax:
       sudo nginx -t

    Reload nginx:
       sudo systemctl reload nginx
    '
}

install_certbot() {
    echo -e "\nInstall certbot:"
    [[ $DEBIAN_FRONTEND == "noninteractive" ]] || sleep 1
    (
        set -x
        # Based on: https://certbot.eff.org/instructions?ws=nginx&os=pip
        sudo apt install python3 python3-venv libaugeas0
        sudo python3 -m venv /opt/certbot/
        sudo /opt/certbot/bin/pip install --upgrade pip
        sudo /opt/certbot/bin/pip install certbot certbot-nginx
        sudo ln -sf /opt/certbot/bin/certbot /usr/bin/certbot
        echo "0 0,12 * * * root /opt/certbot/bin/python -c 'import random; import time; time.sleep(random.random() * 3600)' && sudo certbot renew -q" | sudo tee /etc/cron.d/certbot > /dev/null
    )
}

install_nginx
list_all_avaliable_modules
nginx_status
install_certbot
about_nginx
