#!/bin/bash
set -eo pipefail

# nvm is node version manager for Node.js
# https://github.com/nvm-sh/nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

if ! grep '^export NVM_DIR="$HOME/.nvm"' ~/.zshrc >/dev/null && ! grep '"$NVM_DIR/nvm.sh"' ~/.zshrc >/dev/null; then
    echo '
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
' >> ~/.zshrc
fi