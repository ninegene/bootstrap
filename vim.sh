#!/bin/bash
set -e

BASE_DIR=$(cd "$(dirname "$(readlink -f "$0")")" && pwd)

vim_bundle() {
    local url=$1
    local dir=$BASE_DIR/vim/bundle/$(basename $url)

    if [[ ${dir: -4} == ".git" ]]; then
        dir=${dir%%????} # remove last '.git'
    fi

    echo "$dir ---"
    if [[ -d $dir ]]; then
        cd $dir
        git pull
    else
        cd $BASE_DIR/vim/bundle
        git clone $url $dir
    fi
}

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

main() {
    local BUNDLE_DIR=$BASE_DIR/vim/bundle

    mkdir -p $BASE_DIR/vim/{autoload,bundle}
    curl -LSso $BASE_DIR/vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

    # File Browsing/Searching
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

    # Interactive Command Execution
    #[[ ! -d $BUNDLE_DIR/vimproc.vim ]] && make_vimproc=true
    #vim_bundle https://github.com/Shougo/vimproc.vim.git
    #[[ $make_vimproc == 'true' ]] && cd $BUNDLE_DIR/vimproc.vim && make
    #vim_bundle https://github.com/Shougo/vimshell.vim.git

    # Git
    vim_bundle https://github.com/airblade/vim-gitgutter.git
    vim_bundle https://github.com/tpope/vim-fugitive.git

    # Coding: Autocomplete, Snippets
    vim_bundle https://github.com/majutsushi/tagbar.git
    vim_bundle https://github.com/Shougo/neocomplete.vim.git
    vim_bundle https://github.com/SirVer/ultisnips.git
    vim_bundle https://github.com/honza/vim-snippets.git

    # Syntax: Markdown, CSS, SASS, LESS
    vim_bundle https://github.com/scrooloose/syntastic.git
    vim_bundle https://github.com/tpope/vim-markdown.git
    vim_bundle https://github.com/hail2u/vim-css3-syntax.git
    vim_bundle https://github.com/tpope/vim-haml.git
    vim_bundle https://github.com/groenewege/vim-less.git

    # Python
    vim_bundle https://github.com/davidhalter/jedi-vim.git

    # Backup and symlink directory and files
    symlink "$BASE_DIR/vim" "$HOME/.vim"
    symlink "$BASE_DIR/vim/vimrc" "$HOME/.vimrc"
    symlink "$BASE_DIR/vim/gvimrc" "$HOME/.gvimrc"
    symlink "$BASE_DIR/vim/ctags" "$HOME/.ctags"
}

main
