#!/bin/bash
set -eo pipefail

# Install rbenv and ruby-build so Ruby versions can be managed per project.
brew install rbenv ruby-build

# shellcheck disable=SC2016
if ! grep -q '^eval "$(rbenv init - zsh)"' ~/.zshrc; then
    echo 'eval "$(rbenv init - zsh)"' >>~/.zshrc
fi

echo "rbenv installed version:"
rbenv --version

echo "Install a Ruby version with:"
echo "  rbenv install 3.4.4"
echo "  rbenv global 3.4.4"
