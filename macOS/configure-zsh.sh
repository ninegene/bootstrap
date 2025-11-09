#!/bin/bash
set -eo pipefail

echo "Configuring Zsh..."
# shellcheck disable=SC2016
if ! grep -q '^source $HOME/bootstrap/macOS/zsh_aliases' ~/.zshrc; then
    echo "Updating ~/.zshrc to load zsh_aliases..."
    echo 'source $HOME/bootstrap/macOS/zsh_aliases' >>~/.zshrc
fi

echo "Configuring .screenrc file..."
if [ ! -f ~/.screenrc ]; then
    ln -vs "$HOME/bootstrap/macOS/screenrc" ~/.screenrc
fi

echo "Zsh configuration completed."
