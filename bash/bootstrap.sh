#!/bin/bash
#option=$1
option=--verbose

verbose=0; [ "$option" = "--verbose" ] && verbose=1
cur_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
timestamp=`date +%F-%s`

#echo option=$option verbose=$verbose cur_dir=$cur_dir

function exec {
  # $@ - expands to all command-line parameters separated by spaces
  [ $verbose -eq 1 ] && echo " run:" $@
  $@
}

function backup_file {
  filename=$1
  file=$HOME/$filename
  if [ -f "$file" -a ! -L "$file" ]; then
    exec mv "$file" "$file-$timestamp" 
  fi
}

function remove_symlink {
  filename=$1
  file=$HOME/$filename
  if [ -L "$file" ]; then
    exec rm "$file"
  fi
}

function make_symlink {
  filename=$1
  if [ -f "$cur_dir/$filename" ]; then
    exec ln -s "$cur_dir/$filename" "$HOME/$filename"
  fi
}

function setup_file {
  filename=$1
  backup_file $filename
  remove_symlink $filename
  make_symlink $filename
}

setup_file .bashrc
setup_file .bash_aliases
setup_file .bash_profile
setup_file .bash_local
setup_file .bash_login
setup_file .profile
setup_file .aliases
setup_file .vimrc.before
setup_file .vimrc.after

echo "Done bootstrapping!"
