#!/bin/bash
option=$1

verbose=0; [ "$option" = "--verbose" ] && verbose=1
base_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
timestamp=`date +%F-%s`

function exec {
  # $@ - expands to all command-line parameters separated by spaces
  [ $verbose -eq 1 ] && echo " run:" $@
  $@
}

function backup_file {
  local src=$1

  if [ -d "$src" ] || [ -f "$src" -a ! -L "$src" ]; then
    echo Found "$src" and backing up to "$src-$timestamp"
    exec mv "$src" "$src-$timestamp"
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
  sudo ./install-dependencies.sh
  echo " "
  setup_file "$base_dir/bash/.bashrc" "$HOME/.bashrc"
  setup_file "$base_dir/bash/.bash_aliases" "$HOME/.bash_aliases"
  setup_file "$base_dir/bash/.bash_profile" "$HOME/.bash_profile"
  setup_file "$base_dir/bash/.bash_login" "$HOME/.bash_login"
  setup_file "$base_dir/bash/.profile" "$HOME/.profile"
  setup_file "$base_dir/bash/.aliases" "$HOME/.aliases"

  mkdir -p $HOME/.config/fish
  setup_file "$base_dir/fish/fish_prompt.fish" "$HOME/.config/fish/fish_prompt.fish"
  setup_file "$base_dir/fish/aliases.fish" "$HOME/.config/fish/aliases.fish"
  setup_file "$base_dir/fish/functions" "$HOME/.config/fish/functions"
  setup_file "$base_dir/fish/config.fish" "$HOME/.config/fish/config.fish"

  setup_file "$base_dir/.vimrc" "$HOME/.vimrc"
  setup_file "$base_dir/.gvimrc" "$HOME/.gvimrc"
  setup_file "$base_dir/.ctags" "$HOME/.ctags"
  setup_file "$base_dir/.vim" "$HOME/.vim"

  setup_file "$base_dir/.gitconfig" "$HOME/.gitconfig"

  echo "Done bootstrapping!"
}

main
