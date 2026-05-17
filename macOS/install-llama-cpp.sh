#!/bin/bash
set -eo pipefail

# Install llama.cpp for local LLM inference and CLI tooling.
if command -v llama-cli >/dev/null 2>&1; then
    echo "llama.cpp is already installed: $(llama-cli --version | head -n 1)"
    exit 0
fi

brew install llama.cpp

set -x
llama-cli --version
