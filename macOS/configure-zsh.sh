#!/bin/bash
set -eo pipefail

if ! grep '^source $HOME/bootstrap/macOS/zsh_config/zsh_aliases' ~/.zshrc >/dev/null; then
    echo "source $HOME/bootstrap/macOS/zsh_config/zsh_aliases" >> ~/.zshrc
fi
