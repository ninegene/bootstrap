#!/bin/bash
set -e

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh > /tmp/nvm_install.sh
chmod a+x /tmp/nvm_install.sh
/tmp/nvm_install.sh

. ${HOME}/.nvm/nvm.sh
nvm install node
nvm alias default node
