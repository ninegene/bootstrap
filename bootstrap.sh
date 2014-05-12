#!/bin/bash

set -e

option=$1

# verbose=0; [ "$option" = "--verbose" ] && verbose=1
verbose=1

# install dependency packages by default unless "--update" arg is supplied
install_pkgs=0; [ "$option" = "--install" ] && install_pkgs=1

base_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
timestamp=`date +%F-%s`

function exec {
  # $@ - expands to all command-line parameters separated by spaces
  [ $verbose -eq 1 ] && echo " run:" $@
  $@
}

function backup_file {
  local src=$1

  if [ -f "$src" -a ! -L "$src" ] || [ -d "$src" -a ! -L "$src" ]; then
    backup_dir="$HOME/.dotfiles_backup"
    exec mkdir -p $backup_dir
    echo Found "$src" and backing up to "$src-$timestamp"
    exec mv "$src" "$src-$timestamp"
    exec mv "$src-$timestamp" "$backup_dir/"
  fi
}

function remove_symlink {
  local src=$1

  if [ -L "$src" ]; then
    echo Removing symlink "$src"
    exec rm "$src"
  fi
}

function make_symlink {
  local src=$1
  local dst=$2

  if [ -f "$src" -o -d "$src" ]; then
    echo Creating link file "$dst" from "$src"
    exec ln -s "$src" "$dst"
    echo " "
  fi
}

function setup_file {
  local src=$1
  local dst=$2

  backup_file "$dst"
  remove_symlink "$dst"
  make_symlink "$src" "$dst"
}

function main {
  git submodule update --init --recursive
  if [ $install_pkgs -eq 1 ]; then
      sudo ./bin/install-dependencies.sh
  fi
  echo " "
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
  if [ ! -f "$HOME/.vimrc.local" ]; then
      exec touch "$HOME/.vimrc.local"
  fi

  # setup_file "$base_dir/.gitconfig" "$HOME/.gitconfig"
  remove_symlink "$HOME/.gitconfig"
  backup_file "$HOME/.gitconfig"
  exec cp "$base_dir/.gitconfig" "$HOME/.gitconfig"
  sed -i "s/name = unknown/name = $(whoami)/" "$HOME/.gitconfig"
  sed -i "s/email = unknown/email = $(whoami)@$(hostname)/" "$HOME/.gitconfig"

  echo "Done bootstrapping!"
}

main
