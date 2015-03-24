#!/bin/bash
set -e

show_help() {
cat << EOF
USAGE
    $(basename $0) {all|pkgs|gitconfig|bash|fish|scripts|vim}

DESCRIPTION
    all         Execute all below options (Default)
    pkgs        Install base packages
    gitconfig   Setup git config and git aliases
    bash        Setup dotfiles for BASH
    fish        Setup fish shell config
    scripts     Symlink scripts to ~/bin directory
    vim         Setup VIM plugins
EOF
}

BASE_DIR=$(cd "$(dirname "$(readlink -f "$0")")" && pwd)

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
        echo "Backed up file to $backup"
    elif [[ -d $file ]]; then
        local backup=${file}.$(date +%Y%m%d%H%M%S).bak
        mv "$file" "$backup"
        echo "Backed up dir to $backup"
    fi
}

symlink() {
    local src=$1
    local dst=$2

    backup "$dst"
    ln -s "$src" "$dst"
    echo "Created symlink $dst"
}

install_pkgs() {
    $BASE_DIR/pkgs.sh
}

setup_gitconfig() {
    $BASE_DIR/gitconfig.sh
}

setup_bash() {
    backup "$HOME/.bash_login"
    backup "$HOME/.bash_profile"
    backup "$HOME/.bash_aliases"

    symlink "$BASE_DIR/bash/profile" "$HOME/.profile"
    symlink "$BASE_DIR/bash/bashrc" "$HOME/.bashrc"
    symlink "$BASE_DIR/bash/aliases" "$HOME/.aliases"
}

setup_fish() {
    symlink "$BASE_DIR/fish/profile.fish" "$HOME/.config/fish/profile.fish"
    symlink "$BASE_DIR/fish/prompt.fish" "$HOME/.config/fish/prompt.fish"
    symlink "$BASE_DIR/fish/aliases.fish" "$HOME/.config/fish/aliases.fish"
    symlink "$BASE_DIR/fish/config.fish" "$HOME/.config/fish/config.fish"

    mkdir -p $HOME/.config/fish/functions
    symlink "$BASE_DIR/fish/functions/source_script.fish" "$HOME/.config/fish/functions/source_script.fish"
}

setup_vim() {
    $BASE_DIR/vim.sh
}

setup_scripts() {
    mkdir -p $HOME/bin
    for file in $(find $BASE_DIR/scripts/ -executable -type f)
    do
	    symlink $file $HOME/bin/$(basename $file)
    done
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
        setup_scripts
        exit 0
    fi

    [[ $option =~ pkgs ]] && install_pkgs
    [[ $option =~ git ]] && setup_gitconfig
    [[ $option =~ bash ]] && setup_bash
    [[ $option =~ fish ]] && setup_fish
    [[ $option =~ vim ]] && setup_vim
    [[ $option =~ scripts ]] && setup_scripts
}

main $@
