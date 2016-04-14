#!/bin/bash
set -e

readonly PROG=`perl -e 'use Cwd "abs_path";print abs_path(shift)' $0`
readonly PROGDIR=$(dirname ${PROG})

md5() {
    local file=$1
    if command -v md5sum > /dev/null 2>&1; then
        echo $(md5sum "$file" | egrep -o "[a-zA-Z0-9]{32}")
    else
        echo $(openssl md5 "$file" | egrep -o "[a-zA-Z0-9]{32}")
    fi
}

backup() {
    local file=$1

    if [[ -L $file ]]; then
        (set -x; rm "$file")
        echo "Deleted symlink $file"
    elif [[ -f $file ]]; then
        local backup=${file}.$(md5 "$file").bak
        (set -x; mv "$file" "$backup")
        echo "Backed up $file to $backup"
    elif [[ -d $file ]]; then
        local backup=${file}.$(date +%Y%m%d%H%M%S).bak
        (set -x; mv "$file" "$backup")
        echo "Backed up $file to $backup"
    fi
}

symlink() {
    local src=$1
    local dst=$2

    backup "$dst"
    (set -x; ln -s "$src" "$dst")
    echo "Created symlink $dst"
}

config_bash() {
    backup "$HOME/.bash_login"
    backup "$HOME/.bash_profile"
    backup "$HOME/.bash_aliases"

    symlink "$PROGDIR/bash/profile" "$HOME/.profile"
    symlink "$PROGDIR/bash/bashrc" "$HOME/.bashrc"
    symlink "$PROGDIR/bash/aliases" "$HOME/.aliases"
}

config_fish() {
    mkdir -p $HOME/.config/fish/functions

    symlink "$PROGDIR/fish/profile.fish" "$HOME/.config/fish/profile.fish"
    symlink "$PROGDIR/fish/prompt.fish" "$HOME/.config/fish/prompt.fish"
    symlink "$PROGDIR/fish/aliases.fish" "$HOME/.config/fish/aliases.fish"
    symlink "$PROGDIR/fish/config.fish" "$HOME/.config/fish/config.fish"
    symlink "$PROGDIR/fish/nvm.fish" "$HOME/.config/fish/nvm.fish"

    symlink "$PROGDIR/fish/functions/source_script.fish" "$HOME/.config/fish/functions/source_script.fish"

    if [[ -d $HOME/.config/fish/plugin-foreign-env/.git ]]; then
        cd $HOME/.config/fish/plugin-foreign-env
        git pull
    else
        cd $HOME/.config/fish/
        git clone https://github.com/oh-my-fish/plugin-foreign-env
    fi
}

config_bash
config_fish
