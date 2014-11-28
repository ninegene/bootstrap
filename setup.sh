#!/bin/bash
set -e

show_help() {
cat << EOF
USAGE
    $(basename $0) {pkgs|git|bash|fish|vim|scripts|all}

DESCRIPTION
    pkgs        Install packages
    git         Setup git config and git aliases
    bash        Setup dotfiles for BASH
    fish        Setup fish shell config
    vim         Setup VIM plugins
    scripts     Symlink scripts to ~/bin directory
    all         Execute all above options
EOF
}

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

md5() {
    local file=$1
    if command -v md5sum > /dev/null 2>&1; then
        echo $(md5sum "$file" > egrep -o "[a-zA-Z0-9]{32}")
    else
        echo $(openssl md5 "$file" > egrep -o "[a-zA-Z0-9]{32}")
    fi
}

backup() {
    local file=$1

    if [[ -L $file ]]; then
        rm "$file"
        echo "Deleted symlink $file"
    elif [[ -f $file ]]; then
        local backup=${file}.$(md5 "$file")
        mv "$file" "$backup"
        echo "Backed up file $file to $backup"
    elif [[ -d $file ]]; then
        local backup=${file}.$(date +%Y%m%d%H%M%S)
        mv "$file" "$backup"
        echo "Backed up dir $file to $backup"
    fi
}

symlink() {
    local file=$1
    local link=$2

    backup "$file" 

    ln -s "$file" "$link"
    echo "Created symlink $link from $file"
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
    mkdir -p "$BASE_DIR/fish/functions"

    symlink "$BASE_DIR/fish/profile.fish" "$HOME/.config/fish/profile.fish"
    symlink "$BASE_DIR/fish/prompt.fish" "$HOME/.config/fish/prompt.fish"
    symlink "$BASE_DIR/fish/aliases.fish" "$HOME/.config/fish/aliases.fish"
    symlink "$BASE_DIR/fish/functions/source_script.fish" "$HOME/.config/fish/functions/source_script.fish"
    symlink "$BASE_DIR/fish/config.fish" "$HOME/.config/fish/config.fish"
}

git_clone() {
    local url=$1
    local dir=$2
    if [[ -d $dir ]]; then
        echo $dir
        cd $dir && git pull
    else
        git clone $url $dir
    fi
}

setup_vim() {
    mkdir -p $BASE_DIR/vim/{autoload,bundle}
    curl -LSso $BASE_DIR/vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

    cd $BASE_DIR/vim/bundle

    # File browsing
    git_clone https://github.com/mhinz/vim-startify.git
    git_clone https://github.com/scrooloose/nerdtree.git
    git_clone https://github.com/kien/ctrlp.vim.git
    git_clone https://github.com/vim-scripts/grep.vim

    # Git
    git_clone https://github.com/airblade/vim-gitgutter.git
    git_clone https://github.com/tpope/vim-fugitive.git

    # Editing
    git_clone https://github.com/tpope/vim-repeat.git
    git_clone https://github.com/tpope/vim-scriptease.git
    git_clone https://github.com/tpope/vim-eunuch.git
    git_clone https://github.com/tpope/vim-surround.git
    git_clone https://github.com/tpope/vim-unimpaired.git
    git_clone https://github.com/tpope/vim-commentary.git

    # Visual
    git_clone https://github.com/bling/vim-airline.git

    cd -

    [[ -d $HOME/.vim ]] && mv $HOME/.vim $HOME/.vim-$(date +%Y%m%d%H%M%S)
    [[ -L $HOME/.vim ]] && rm $HOME/.vim

    symlink $BASE_DIR/vim $HOME/.vim
    symlink "$BASE_DIR/vim/vimrc" "$BASE_DIR/.vimrc"
    symlink "$BASE_DIR/vim/gvimrc" "$BASE_DIR/.gvimrc"
    symlink "$BASE_DIR/vim/ctags" "$BASE_DIR/.ctags"
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
