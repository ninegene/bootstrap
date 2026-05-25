#!/bin/bash
set -eo pipefail

if command -v npm >/dev/null 2>&1; then
    npm install -g @google/gemini-cli
else
    echo "npm not found. Install Node.js 24 first."
    exit 1
fi

gemini --version
