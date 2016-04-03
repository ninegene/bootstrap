#!/bin/bash
set -e

PROGDIR=$(cd $(dirname "$0"); pwd)
VIMDIR=$PROGDIR

vim_bundle() {
    local url=$1
    local dir=$VIMDIR/bundle/$(basename $url)

    if [[ ${dir: -4} == ".git" ]]; then
        dir=${dir%%????} # remove last '.git'
    fi

    echo "$dir ---"
    if [[ -d $dir ]]; then
        cd $dir
        git pull
    else
        cd $VIMDIR/bundle
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
    mkdir -p $VIMDIR/{autoload,bundle}
    curl -LSso $VIMDIR/autoload/pathogen.vim https://tpo.pe/pathogen.vim

    # File Browsing/Searching
    vim_bundle https://github.com/mhinz/vim-startify.git
    vim_bundle https://github.com/scrooloose/nerdtree.git
    vim_bundle https://github.com/kien/ctrlp.vim.git
    vim_bundle https://github.com/vim-scripts/grep.vim.git

    # Visual
    vim_bundle https://github.com/bling/vim-airline.git

    # General Editing
    vim_bundle https://github.com/tpope/vim-repeat.git
    vim_bundle https://github.com/tpope/vim-scriptease.git
    vim_bundle https://github.com/tpope/vim-endwise.git
    vim_bundle https://github.com/tpope/vim-eunuch.git
    vim_bundle https://github.com/tpope/vim-surround.git
    vim_bundle https://github.com/tpope/vim-unimpaired.git
    vim_bundle https://github.com/tpope/vim-commentary.git
    vim_bundle https://github.com/sjl/gundo.vim.git

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
    vim_bundle https://github.com/jmcantrell/vim-virtualenv.git

    # Interactive Command Execution
    [[ ! -d $VIMDIR/bundle/vimproc.vim ]] && make_vimproc=true
    vim_bundle https://github.com/Shougo/vimproc.vim.git
    [[ $make_vimproc == 'true' ]] && cd $VIMDIR/bundle/vimproc.vim && make
    vim_bundle https://github.com/Shougo/vimshell.vim.git

    # Mac specific Api doc lookup app
    [[ -d /Applications/Dash.app ]] && vim_bundle https://github.com/rizzatti/dash.vim.git

    # Backup and symlink directory and files
    symlink "$VIMDIR" "$HOME/.vim"
    symlink "$VIMDIR/vimrc" "$HOME/.vimrc"
    symlink "$VIMDIR/gvimrc" "$HOME/.gvimrc"
    symlink "$VIMDIR/ctags" "$HOME/.ctags"
}

main
