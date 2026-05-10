#!/bin/bash
set -eo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Configuring Zsh..."
if ! grep -q "^source $REPO_ROOT/macOS/zsh_aliases" ~/.zshrc; then
    echo "Updating ~/.zshrc to load zsh_aliases..."
    echo "source $REPO_ROOT/macOS/zsh_aliases" >>~/.zshrc
fi

echo "Configuring .screenrc file..."
if [ ! -f ~/.screenrc ]; then
    ln -vs "$REPO_ROOT/macOS/screenrc" ~/.screenrc
fi

echo "Zsh configuration completed."
