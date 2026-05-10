#!/bin/bash
set -eo pipefail

if command -v npm >/dev/null 2>&1; then
    npm install -g @anthropic-ai/claude-code
else
    echo "npm not found. Install Node.js 24 first."
    exit 1
fi

claude --version
