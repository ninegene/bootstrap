#!/bin/bash
set -e

show_help() {
cat << EOF
USAGE
    $(basename $0) {all|pkgs|gitconfig|bash|fish|vim}

DESCRIPTION
    all         Execute all below options (Default)
    pkgs        Install base packages
    gitconfig   Setup git config and git aliases
    bash        Setup dotfiles for BASH
    fish        Setup fish shell config
    vim         Setup VIM plugins
EOF
}

if command -v greadlink > /dev/null; then
    CURDIR=$(dirname "$(greadlink -f "$0")")
else
    CURDIR=$(dirname "$(readlink -f "$0")")
fi

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
        rm "$file"
        echo "Deleted symlink $file"
    elif [[ -f $file ]]; then
        local backup=${file}.$(md5 "$file").bak
        mv "$file" "$backup"
        echo "Backed up $file to $backup"
    elif [[ -d $file ]]; then
        local backup=${file}.$(date +%Y%m%d%H%M%S).bak
        mv "$file" "$backup"
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

install_pkgs() {
    $CURDIR/pkgs.sh
}

setup_gitconfig() {
    $CURDIR/git/config.sh
}

setup_bash() {
    backup "$HOME/.bash_login"
    backup "$HOME/.bash_profile"
    backup "$HOME/.bash_aliases"

    symlink "$CURDIR/bash/profile" "$HOME/.profile"
    symlink "$CURDIR/bash/bashrc" "$HOME/.bashrc"
    symlink "$CURDIR/bash/aliases" "$HOME/.aliases"
}

setup_fish() {
    symlink "$CURDIR/fish/profile.fish" "$HOME/.config/fish/profile.fish"
    symlink "$CURDIR/fish/prompt.fish" "$HOME/.config/fish/prompt.fish"
    symlink "$CURDIR/fish/aliases.fish" "$HOME/.config/fish/aliases.fish"
    symlink "$CURDIR/fish/config.fish" "$HOME/.config/fish/config.fish"

    mkdir -p $HOME/.config/fish/functions
    symlink "$CURDIR/fish/functions/source_script.fish" "$HOME/.config/fish/functions/source_script.fish"
}

setup_vim() {
    $CURDIR/vim/setup.sh
}

main() {
    if [[ $1 == '-h' || $1 == '--help' || $1 == 'help' ]]; then
        show_help
        exit 0
    fi

    local option=${1-all}

    if [[ $option == 'all' ]]; then
        install_pkgs
        setup_gitconfig
        setup_bash
        setup_fish
        setup_vim
        exit 0
    fi

    [[ $option =~ pkgs ]] && install_pkgs
    [[ $option =~ git ]] && setup_gitconfig
    [[ $option =~ bash ]] && setup_bash
    [[ $option =~ fish ]] && setup_fish
    [[ $option =~ vim ]] && setup_vim
}

main $@
