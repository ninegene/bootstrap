#!/bin/bash
set -eo pipefail

# https://antigravity.google/docs/cli-getting-started

if command -v agy >/dev/null 2>&1; then
    echo "Antigravity CLI already installed."
else
    curl -fsSL https://antigravity.google/cli/install.sh | bash
fi

if command -v agy >/dev/null 2>&1; then
    agy --version || true
else
    echo "Antigravity CLI installation finished, but 'agy' is not on PATH yet."
    echo "Open a new terminal and run: agy --version"
fi
