#!/bin/bash
set -eo pipefail

if command -v hf >/dev/null 2>&1; then
    echo "huggingface_hub is already installed: $(hf version)"
    exit 0
fi

if ! command -v uv >/dev/null 2>&1; then
    echo "uv not found. Install it first: bash macOS/install-uv.sh"
    exit 1
fi

uv tool install huggingface_hub

hf version
