#!/bin/bash
set -eo pipefail

# https://github.com/olivierverdier/zsh-git-prompt
brew install zsh-git-prompt

if ! grep -q '^source "/usr/local/opt/zsh-git-prompt/zshrc.sh"'; then
    echo 'source "/usr/local/opt/zsh-git-prompt/zshrc.sh"' >> ~/.zshrc
fi