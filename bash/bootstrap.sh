#!/bin/bash
#option=$1
option=--verbose

verbose=0; [ "$option" = "--verbose" ] && verbose=1
cur_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
base_dir="$( cd "$cur_dir/.." && pwd )"
timestamp=`date +%F-%s`

echo option=$option verbose=$verbose base_dir=$base_dir cur_dir=$cur_dir

function exec {
  # $@ - expands to all command-line parameters separated by spaces
  [ $verbose -eq 1 ] && echo " run:" $@
  $@
}

function backup_file {
  local src=$1

  if [ -f "$src" -a ! -L "$src" ]; then
    exec mv "$src" "$src-$timestamp" 
  fi
}

function remove_symlink {
  local src=$1

  if [ -L "$src" ]; then
    exec rm "$src"
  fi
}

function make_symlink {
  local src=$1
  local dst=$2

  if [ -f "$src" -o -d "$src" ]; then
    exec ln -s "$src" "$dst"
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
  setup_file "$cur_dir/.bashrc" "$HOME/.bashrc" 
  setup_file "$cur_dir/.bash_aliases" "$HOME/.bash_aliases" 
  setup_file "$cur_dir/.bash_profile" "$HOME/.bash_profile"
  setup_file "$cur_dir/.bash_login" "$HOME/.bash_login"
  setup_file "$cur_dir/.profile" "$HOME/.profile"
  setup_file "$cur_dir/.aliases" "$HOME/.aliases"
  setup_file "$base_dir/.vimrc" "$HOME/.vimrc"
  setup_file "$base_dir/.gvimrc" "$HOME/.gvimrc"
  setup_file "$base_dir/.vim" "$HOME/.vim"

  echo "Done bootstrapping!"
}

main
