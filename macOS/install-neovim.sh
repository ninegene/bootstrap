#!/bin/bash
set -eo pipefail

curdir=$(cd "$(dirname "$0")"; pwd -P)

set -x
brew install neovim
brew install ctags
brew install ripgrep
brew install lua-language-server

# https://github.com/wbthomason/packer.nvim
if [[ -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]]; then
    cd ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    git pull
else
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
        ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

