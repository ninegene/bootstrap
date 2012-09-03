#!/bin/bash
# base on https://raw.github.com/mathiasbynens/dotfiles/master/bootstrap.sh
cd "$(dirname "$0")"

#git pull

function doIt() {
	rsync --exclude ".git/" --exclude ".gitmodules" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av . ~
}

if [ "$1" == "--confirm" -o "$1" == "-c" ]; then
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
else
	doIt
fi
unset doIt

source ~/.bash_profile
source ~/.bashrc
