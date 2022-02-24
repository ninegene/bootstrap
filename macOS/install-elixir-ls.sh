#!/bin/bash
set -eo pipefail

# https://www.mitchellhanberg.com/how-to-set-up-neovim-for-elixir-development/
set -x
mkdir -p  ~/.cache/nvim/lspconfig/elixirls
cd ~/.cache/nvim/lspconfig/elixirls

if [[ ! -d elixir-ls/.git ]]; then
    git clone git@github.com:elixir-lsp/elixir-ls.git
else
    cd elixir-ls
    git pull
    cd -
fi

cd elixir-ls
mix deps.get
mix compile
mix elixir_ls.release -o release
