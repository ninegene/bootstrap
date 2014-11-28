#!/bin/bash
set -e

show_help() {
cat << EOF
USAGE
    $(basename $0) {pkgs|git|bash|fish|vim|scripts|all}

DESCRIPTION
    pkgs        Install base packages
    git         Setup git config and git aliases
    bash        Setup dotfiles for BASH
    fish        Setup fish shell config
    vim         Setup VIM plugins
    scripts     Symlink scripts to ~/bin directory
    all         Execute all above options (Default)
EOF
}

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
    $BASE_DIR/install-pkgs.sh
}

setup_gitconfig() {
    backup "$BASE_DIR/.gitconfig"
    cp "$BASE_DIR/.gitconfig" "$HOME/.gitconfig"

    sed -i "s/name = unknown/name = $(whoami)/" "$HOME/.gitconfig"
    sed -i "s/email = unknown/email = $(whoami)@$(hostname)/" "$HOME/.gitconfig"
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

vim_bundle() {
    local url=$1
    local dir=$BASE_DIR/vim/bundle/$(basename $url)
    dir=${dir%%????} # remove last '.git'

    echo "$dir ---"
    if [[ -d $dir ]]; then
        cd $dir
        git pull
        cd - > /dev/null 2>&1
    else
        git clone $url $dir
    fi
}

setup_vim() {
    mkdir -p $BASE_DIR/vim/{autoload,bundle}
    curl -LSso $BASE_DIR/vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

    cd $BASE_DIR/vim/bundle

    # File browsing
    vim_bundle https://github.com/mhinz/vim-startify.git
    vim_bundle https://github.com/scrooloose/nerdtree.git
    vim_bundle https://github.com/kien/ctrlp.vim.git
    vim_bundle https://github.com/vim-scripts/grep.vim.git
    vim_bundle https://github.com/mileszs/ack.vim.git

    # Visual
    vim_bundle https://github.com/bling/vim-airline.git

    # General Editing
    vim_bundle https://github.com/tpope/vim-repeat.git
    vim_bundle https://github.com/tpope/vim-scriptease.git
    vim_bundle https://github.com/tpope/vim-eunuch.git
    vim_bundle https://github.com/tpope/vim-surround.git
    vim_bundle https://github.com/tpope/vim-unimpaired.git
    vim_bundle https://github.com/tpope/vim-commentary.git
    vim_bundle https://github.com/sjl/gundo.vim.git
    vim_bundle https://github.com/ervandew/supertab.git

    # Coding
    vim_bundle https://github.com/scrooloose/syntastic.git
    vim_bundle https://github.com/majutsushi/tagbar.git

    #
    vim_bundle https://github.com/airblade/vim-gitgutter.git
    vim_bundle https://github.com/tpope/vim-fugitive.git

    # Python
    vim_bundle https://github.com/davidhalter/jedi-vim.git

    cd - > /dev/null 2>&1

    [[ -d $HOME/.vim ]] && mv $HOME/.vim $HOME/.vim-$(date +%Y%m%d%H%M%S)
    [[ -L $HOME/.vim ]] && rm $HOME/.vim

    symlink $BASE_DIR/vim $HOME/.vim
    symlink "$BASE_DIR/vim/vimrc" "$BASE_DIR/vim/.vimrc"
    symlink "$BASE_DIR/vim/gvimrc" "$BASE_DIR/vim/.gvimrc"
    symlink "$BASE_DIR/vim/ctags" "$BASE_DIR/vim/.ctags"
}

setup_scripts() {
    local file
    for file in "$basedir/scripts/*"
    do
        echo $file
    done
}

main() {
    if [[ $1 == '-h' || $1 == '--help' ]]; then
        show_help
        exit 0
    fi

    local option=${1-all}

    [[ $option == 'pkgs' ]] && install_pkgs && exit 0
    [[ $option == 'git' ]] && setup_gitconfig && exit 0
    [[ $option == 'bash' ]] && setup_bash && exit 0
    [[ $option == 'fish' ]] && setup_fish && exit 0
    [[ $option == 'vim' ]] && setup_vim && exit 0
    [[ $option == 'scripts' ]] && setup_scripts && exit 0

    if [[ $option == 'all' ]]; then
        install_pkgs
        setup_git
        setup_bash
        setup_fish
        setup_vim
        setup_scripts
        exit 0
    fi
}

main $@
