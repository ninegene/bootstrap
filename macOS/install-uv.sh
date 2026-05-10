#!/bin/bash
set -eo pipefail

if command -v uv >/dev/null 2>&1; then
    echo "uv is already installed: $(uv --version)"
    exit 0
fi

curl -LsSf https://astral.sh/uv/install.sh | sh

export PATH="$HOME/.local/bin:$PATH"
# shellcheck disable=SC1090,SC1091
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

set -x
uv --version
