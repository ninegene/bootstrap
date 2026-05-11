#!/bin/bash
set -eo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ZSH_ALIASES_SOURCE="source $REPO_ROOT/macOS/zsh_aliases"

echo "Configuring Zsh..."
if [ -f ~/.zshrc ]; then
    perl -0pi -e 's|^source .*/bootstrap/macOS/zsh_aliases$||mg' ~/.zshrc
fi

if ! grep -Fxq "$ZSH_ALIASES_SOURCE" ~/.zshrc; then
    echo "Updating ~/.zshrc to load zsh_aliases..."
    echo "$ZSH_ALIASES_SOURCE" >>~/.zshrc
fi

echo "Configuring .screenrc file..."
if [ ! -e ~/.screenrc ] && [ ! -L ~/.screenrc ]; then
    ln -vs "$REPO_ROOT/macOS/screenrc" ~/.screenrc
fi

echo "Zsh configuration completed."
