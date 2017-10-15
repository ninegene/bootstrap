#!/bin/bash
set -euxo pipefail

cd /var/www/
if [[ ! -e linux-dash ]]; then
    # Original repo
    # sudo git clone --depth 1 https://github.com/afaqurk/linux-dash.git
    sudo git clone --depth 1 https://github.com/ninegene/linux-dash
fi

sudo chown -R ${USER}:${USER} linux-dash
# Use nvm if installed
if [[ -f ${HOME}/.nvm/nvm.sh ]]; then
    . ${HOME}/.nvm/nvm.sh
fi

cd linux-dash/app/server
npm install --production
npm install -g forever
LINUX_DASH_SERVER_PORT=5555 forever start --append -l forever.log -o out.log -e err.log -d -v index.js
