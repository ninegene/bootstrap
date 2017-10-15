#!/bin/bash
set -euxo pipefail

# Make sure node.js is installed

cd /var/www/
if [[ ! -e linux-dash ]]; then
    # Original repo
    # sudo git clone --depth 1 https://github.com/afaqurk/linux-dash.git
    sudo git clone --depth 1 https://github.com/ninegene/linux-dash
fi

sudo chown -R ${USER}:${USER} linux-dash
cd linux-dash/app/server

if [[ -f ${HOME}/.nvm/nvm.sh ]]; then
    . ${HOME}/.nvm/nvm.sh
fi

npm install --production
npm install -g pm2
pm2 start index.js --name linux-dash -- --port=5555
pm2 dump
