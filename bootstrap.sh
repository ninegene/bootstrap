#!/bin/bash
ts=`date +%F`

if [ -f ~/.bashrc ]; then
  mv ~/.bashrc ~/.bashrc-backup-$ts
fi

if [ -f ~/.bash_aliases ]; then
  mv ~/.bash_aliases ~/.bash_aliases-backup-$ts
fi

if [ -f ~/.bash_profile ]; then
  mv ~/.bash_profile ~/.bash_profile-backup-$ts
fi

if [ -f ~/.profile ]; then
  mv ~/.profile ~/.profile-backup-$ts
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
