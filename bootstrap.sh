#!/bin/bash
ts=`date +%F-%s`

if [ -f ~/.bashrc -a ! -L ~/.bashrc ]; then
  mv ~/.bashrc ~/.bashrc-$ts
fi

if [ -f ~/.bash_aliases -a ! -L ~/.bash_aliases ]; then
  mv ~/.bash_aliases ~/.bash_aliases-$ts
fi

if [ -f ~/.bash_profile -a ! -L ~/.bash_profile ]; then
  mv ~/.bash_profile ~/.bash_profile-$ts
fi

if [ -f ~/.profile -a ! -L ~/.profile ]; then
  mv ~/.profile ~/.profile-$ts
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

ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.bash_aliases ~/.bash_aliases

if [ "$1" == "server" ]; then
  echo 'Setting up .bash_profile for server'
  ln -s ~/dotfiles/.bash_profile ~/.bash_profile
else
  echo 'Setting up .profile for desktop'
  ln -s ~/dotfiles/.bash_profile ~/.profile
fi
