#!/bin/bash
set -eo pipefail

# Download and install Node.js for global use
brew install node@24

# shellcheck disable=SC2016
if ! grep -q '^export PATH="/usr/local/opt/node@24/bin:$PATH"' ~/.zshrc; then
    echo 'export PATH="/usr/local/opt/node@24/bin:$PATH"' >>~/.zshrc
fi

set -x
# Verify the Node.js version:
/usr/local/opt/node@24/bin/node -v

# Verify npm version:
/usr/local/opt/node@24/bin/npm -v
