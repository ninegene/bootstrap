#!/bin/bash
set -eo pipefail

# https://github.com/cli/cli
brew install gh || true

# Authenticate gh with GitHub
if ! gh auth status >/dev/null 2>&1; then
    gh auth login --web
fi
