#!/bin/bash
set -eo pipefail

# https://github.com/pyenv/pyenv
brew install pyenv || true

echo "pyenv installed version:"
pyenv --version
