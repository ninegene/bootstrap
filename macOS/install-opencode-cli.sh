#!/bin/bash
set -eo pipefail

if command -v brew >/dev/null 2>&1; then
    brew install anomalyco/tap/opencode
else
    echo "brew not found. Install Homebrew first."
    exit 1
fi

opencode --version
