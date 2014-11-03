#!/bin/bash

set -e

# install dependency packages when "--install" arg is supplied
option=${1-"--update"}

base_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
timestamp=`date +%F_%H-%M-%S`

function execho {
  $@
  echo " run:" $@
}

function backup_file {
  local src=$1

  #if [ -f "$src" -a ! -L "$src" ] || [ -d "$src" -a ! -L "$src" ]; then
  if [[ (-f $src && ! -L $src) || (-d $src && ! -L $src) ]]; then
    backup_dir="$HOME/.dotfiles_backup/$timestamp"
    execho mkdir -p $backup_dir
    echo Found "$src" and backing up to "$backup_dir"
    execho mv "$src" "$backup_dir/"
  fi
}

function remove_symlink {
  local src=$1

  if [[ -L $src ]]; then
    echo Removing symlink "$src"
    execho rm "$src"
  fi
}

function make_symlink {
  local src=$1
  local dst=$2

  if [[ -f $src || -d $src ]]; then
    echo Creating link file "$dst" from "$src"
    execho ln -s "$src" "$dst"
    echo " "
  fi
}

function setup_file {
  local src=$1
  local dst=$2

  remove_symlink "$dst"
  backup_file "$dst"
  make_symlink "$src" "$dst"
}

function main {
  git submodule update --init --recursive
  if [[ $option = "--install" || $option = "-i" ]]; then
    ./bin/install-dependencies.sh
  fi
  echo
  setup_file "$base_dir/bash/.profile" "$HOME/.profile"
  setup_file "$base_dir/bash/.bashrc" "$HOME/.bashrc"
  setup_file "$base_dir/bash/.bash_aliases" "$HOME/.bash_aliases"
  setup_file "$base_dir/bash/.bash_login" "$HOME/.bash_login"
  setup_file "$base_dir/bash/.aliases" "$HOME/.aliases"

  mkdir -p $HOME/.config/fish
  setup_file "$base_dir/fish/profile.fish" "$HOME/.config/fish/profile.fish"
  setup_file "$base_dir/fish/prompt.fish" "$HOME/.config/fish/prompt.fish"
  setup_file "$base_dir/fish/aliases.fish" "$HOME/.config/fish/aliases.fish"
  setup_file "$base_dir/fish/functions" "$HOME/.config/fish/functions"
  setup_file "$base_dir/fish/config.fish" "$HOME/.config/fish/config.fish"

  setup_file "$base_dir/.vim/.vimrc" "$HOME/.vimrc"
  setup_file "$base_dir/.vim/.gvimrc" "$HOME/.gvimrc"
  setup_file "$base_dir/.vim/.ctags" "$HOME/.ctags"
  setup_file "$base_dir/.vim" "$HOME/.vim"
  if [[ ! -f $HOME/.vimrc.local ]]; then
    execho touch "$HOME/.vimrc.local"
  fi

  # setup_file "$base_dir/.gitconfig" "$HOME/.gitconfig"
  remove_symlink "$HOME/.gitconfig"
  backup_file "$HOME/.gitconfig"
  execho cp "$base_dir/.gitconfig" "$HOME/.gitconfig"
  sed -i "s/name = unknown/name = $(whoami)/" "$HOME/.gitconfig"
  sed -i "s/email = unknown/email = $(whoami)@$(hostname)/" "$HOME/.gitconfig"

  echo "Done bootstrapping!"
}

main
