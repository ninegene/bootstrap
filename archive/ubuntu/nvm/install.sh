#!/bin/bash
set -eo pipefail

VERSION=$(curl -s  https://raw.githubusercontent.com/creationix/nvm/master/package.json | jq -r '.version')
curl -o- https://raw.githubusercontent.com/creationix/nvm/v${VERSION}/install.sh > /tmp/nvm_install.sh
less /tmp/nvm_install.sh
chmod a+x /tmp/nvm_install.sh
/tmp/nvm_install.sh

. ${HOME}/.nvm/nvm.sh
nvm install node
nvm alias default node
