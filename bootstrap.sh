#!/bin/bash
ts=`date +%F`

if [ -f ~/.bashrc -a ! -L ~/.bashrc ]; then
  mv ~/.bashrc ~/.bashrc-backup-$ts
fi

if [ -f ~/.bash_aliases -a ! -L ~/.bash_aliases ]; then
  mv ~/.bash_aliases ~/.bash_aliases-backup-$ts
fi

if [ -f ~/.bash_profile -a ! -L ~/.bash_profile ]; then
  mv ~/.bash_profile ~/.bash_profile-backup-$ts
fi

if [ -f ~/.profile -a ! -L ~/.profile ]; then
  mv ~/.profile ~/.profile-backup-$ts
fi

if [ -L ~/.bashrc ]; then
  rm ~/.bashrc
fi

if [ -L ~/.bash_aliases ]; then
  rm ~/.bash_aliases
fi

if [ -L ~/.bash_profile ]; then
  rm ~/.bash_profile
fi

if [ -L ~/.profile ]; then
  rm ~/.profile
fi

ln -s $PWD/.bashrc ~/.bashrc
ln -s $PWD/.bash_aliases ~/.bash_aliases

if [ "$1" == "server" ]; then
  echo 'Setting up .bash_profile for server'
  ln -s $PWD/.bash_profile ~/.bash_profile
else
  echo 'Setting up .profile for desktop'
  ln -s $PWD/.profile ~/.profile
fi
