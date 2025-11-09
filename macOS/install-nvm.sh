#!/bin/bash
set -eo pipefail

# nvm is node version manager for Node.js
# https://github.com/nvm-sh/nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# shellcheck disable=SC2016
if ! grep -q '^export NVM_DIR="$HOME/.nvm"' ~/.zshrc && ! grep -q '"$NVM_DIR/nvm.sh"' ~/.zshrc; then
    echo '
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
' >>~/.zshrc
fi
