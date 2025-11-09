#!/bin/bash
set -eo pipefail

# https://github.com/vim/vim
brew install vim || true

echo "Configuring Vim with plugins..."

mkdir -p ~/.vim/pack/tpope/start
cd ~/.vim/pack/tpope/start

git clone https://tpope.io/vim/endwise.git || true

git clone https://tpope.io/vim/repeat.git || true
vim -u NONE -c "helptags repeat/doc" -c q

git clone https://tpope.io/vim/surround.git || true
vim -u NONE -c "helptags surround/doc" -c q

git clone https://tpope.io/vim/unimpaired.git || true
vim -u NONE -c "helptags unimpaired/doc" -c q

git clone https://tpope.io/vim/commentary.git || true
vim -u NONE -c "helptags commentary/doc" -c q

echo "Setup symlink .vimrc"
[[ -L "$HOME/.vimrc" ]] && rm "$HOME/.vimrc"
ln -vs "$HOME/bootstrap/vim/vimrc" "$HOME/.vimrc" || true

echo "Vim configuration completed."
