#!/bin/bash
set -eo pipefail

# Install Go for local development.
if command -v go >/dev/null 2>&1; then
    echo "Go is already installed: $(go version)"
    exit 0
fi

brew install go

set -x
# Verify the Go toolchain:
go version
