#!/bin/bash
set -e

show_help() {
cat << EOF
USAGE
    $(basename $0) {all|pkgs|git|bash|fish|scripts|vim}

DESCRIPTION
    all         Execute all below options (Default)
    pkgs        Install base packages
    git         Setup git config and git aliases
    bash        Setup dotfiles for BASH
    fish        Setup fish shell config
    scripts     Symlink scripts to ~/bin directory
    vim         Setup VIM plugins
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
    $BASE_DIR/base-pkgs.sh
}

setup_gitconfig() {
    git config --global user.name "$(whoami)"
    git config --global user.email "$(whoami)@$(hostname)"

    git config --global push.default simple

    git config --global core.autocrlf input
    git config --global core.editor vi

    git config --global diff.tool diffuse
    if [[ $(uname -s) = 'Darwin' ]]; then
        git config --global diff.tool opendiff
    fi

    git config --global alias.user "config user.name"
    git config --global alias.email "config user.email"
    git config --global alias.aliases "!git config --get-regexp 'alias.*' | colrm 1 6 | sed 's/[ ]/ = /'"

    git config --global alias.st "status --short --branch"

    git config --global alias.co "checkout"
    git config --global alias.cob "checkout -b"

    ## branch ##

    git config --global alias.br "branch -a"

    ## remote ##

    # $ git remote show origin

    ## pull ##

    git config --global alias.update "!git stash save && git pull -v --rebase && git stash pop && git changes"

    ## difftool ##

    git config --global alias.dt "difftool"

    ## diff ##

    # Compare your working directory and the index (staging area for the next commit).
    git config --global alias.df "diff"
    #git config --global alias.dw "diff --word-diff=color"

    # Compare your working directory and the tip of 'dev' branch
    # $ git diff dev

    # Compare 'application.properties' file in your working directory and the one in 'dev' branch
    # $ git diff dev -- application.properties

    # Compare two branches (Note that the branch need to be checked out before or exists)
    # $ git diff dev master
    # $ git diff dev master -- application.properties

    # Compare two remote tracking branches (Run 'git fetch --all' first if necessary)
    # $ git diff origin/dev origin/master

    # Compare two commits (commit before latest and the latest commit)
    # $ git diff HEAD^ HEAD
    # $ git diff HEAD^ HEAD -- application.properties

    # Compare your working directory and the latest commit.
    git config --global alias.dh "diff HEAD"
    #git config --global alias.dhw "diff --word-diff=color HEAD"

    # Compare a specific file(s) in your working directory and the latest commit.
    # $ git dh -- path/to/files
    # $ git dh -- path/**/*/files

    # Compare the index (staging area for the next commit) and the latest commit.
    git config --global alias.ds "diff --staged" # Same as "diff --cached"
    #git config --global alias.dsw "diff --word-diff=color --staged"

    ## reset ##

    # Unstage file or remove file from the index (staging area)
    git config --global alias.unstage 'reset HEAD --'

    # Throw away all changes you made in your working directory.
    # Commit first and reset hard to last commit so that you can recover with 'git reflog' if needed
    # A better way to handle 'git reset HEAD --hard'
    git config --global alias.fullsync "!git add --all && git commit --allow-empty -qm 'fullsync commit' && git reset ${1-HEAD~1} --hard"

    # Reset last commit and keeps all the last commit changes in your working directory
    git config --global alias.resetlast "reset HEAD~1 --mixed"

    # Resetting to origin/HEAD. (Or undo resetting of resetting to last commit.)
    # $ git reset origin/HEAD
    git config --global alias.resethead "reset origin/HEAD"

    ## commit ##

    git config --global alias.ci "commit -m"

    # Commit all changes (adds, modifies, and removes index entries to match the working tree)
    git config --global alias.cia "!git add --all && git commit -m"

    # Commit staged changes (modifires and removes index entries to match the working tree but adds no new files)
    git config --global alias.ciu "!git add --update && git commit -m"

    # Modify last commit
    git config --global alias.amend "commit --amend"

    ## log ##

    # Show last commit
    git config --global alias.last '!git ll -1 HEAD'

    # Show commits in one per line (abbrev commit, short date, tag, message, author)
    git config --global alias.ls "log --abbrev-commit --date=short --pretty=format:'%C(yellow)%h %ad%Creset%Cred%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
    git config --global alias.ll "!git ls --name-status"

    # Show new commits created by the last command (typically after a 'git pull')
    # Example:
    # $ git changes
    # $ git changes origin/master
    git config --global alias.changes "!sh -c 'git ll $1@{1}..$1@{0} $@'"

    # Show all commits since version v2.2.11 that changed any file in the 'src' or 'test' subdirectories
    # (Use 'git tag' to see all version tag)
    # $ git log v2.2.11.. src test

    # Show the commits that are in the "dev" branch but not yet in the 'master' branch,
    # along with the list of paths each commit modifies.
    # $ git log --name-status master..dev
    # $ git ll master..dev

    # Show the commits that changed 'config/application.properties', including those commits that
    # occurred before the file was given its present name. (Show file commit history)
    # $ git log --follow config/application.properties
    git config --global alias.filelog "!git ls --follow"

    # Show file commit history with diffs
    git config --global alias.filechanges "!git ls -u"

    # Show commits in local timezone
    git config --global alias.locallog "log --date=local"

    ## grep ##

    # Case insensitive search text
    git config --global alias.grep "grep -Ii"

    ## ls-files ##

    # Find file name/path
    git config --global alias.fname "!git ls-files | grep -i"

    ## cat-file ##

    git config --global alias.type "cat-file -t"
    git config --global alias.dump "cat-file -p"

    echo "Done setting up git global configs."

    # References
    # http://git-scm.com/book/en/v2/Git-Basics-Git-Aliases
    # https://git.wiki.kernel.org/index.php/Aliases
    # http://haacked.com/archive/2014/07/28/github-flow-aliases/
    # http://durdn.com/blog/2012/11/22/must-have-git-aliases-advanced-examples/
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

setup_scripts() {
    mkdir -p $HOME/bin
    for file in $(find $BASE_DIR/scripts/ -executable -type f)
    do
	symlink $file $HOME/bin/$(basename $file)
    done
}

vim_bundle() {
    local URL=$1
    local PRJ_DIR=$BASE_DIR/vim/bundle/$(basename $URL)

    if [[ ${PRJ_DIR: -4} == ".git" ]]; then
        PRJ_DIR=${PRJ_DIR%%????} # remove last '.git'
    fi

    echo "$PRJ_DIR ---"
    if [[ -d $PRJ_DIR ]]; then
        cd $PRJ_DIR
        git pull
    else
        cd $BASE_DIR/vim/bundle
        git clone $URL $PRJ_DIR
    fi

    cd - > /dev/null 2>&1
}

setup_vim() {
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
    [[ ! -d $BUNDLE_DIR/vimproc.vim ]] && make_vimproc=true
    vim_bundle https://github.com/Shougo/vimproc.vim.git
    [[ $make_vimproc == 'true' ]] && cd $BUNDLE_DIR/vimproc.vim && make
    vim_bundle https://github.com/Shougo/vimshell.vim.git

    # Git
    vim_bundle https://github.com/airblade/vim-gitgutter.git
    vim_bundle https://github.com/tpope/vim-fugitive.git

    # Coding
    vim_bundle https://github.com/scrooloose/syntastic.git
    vim_bundle https://github.com/majutsushi/tagbar.git
    vim_bundle https://github.com/Shougo/neocomplete.vim.git
    vim_bundle https://github.com/SirVer/ultisnips.git
    vim_bundle https://github.com/honza/vim-snippets.git

    # HTML/CSS
    vim_bundle https://github.com/tpope/vim-haml.git
    vim_bundle https://github.com/skammer/vim-css-color.git
    vim_bundle https://github.com/hail2u/vim-css3-syntax.git
    vim_bundle https://github.com/groenewege/vim-less.git

    # Python
    vim_bundle https://github.com/davidhalter/jedi-vim.git
    vim_bundle https://github.com/Yggdroot/indentLine.git

    [[ -d $HOME/.vim ]] && mv $HOME/.vim $HOME/.vim-$(date +%Y%m%d%H%M%S)
    [[ -L $HOME/.vim ]] && rm $HOME/.vim

    symlink $BASE_DIR/vim $HOME/.vim
    symlink "$BASE_DIR/vim/vimrc" "$HOME/.vimrc"
    symlink "$BASE_DIR/vim/gvimrc" "$HOME/.gvimrc"
    symlink "$BASE_DIR/vim/ctags" "$HOME/.ctags"
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
        setup_gitconfig
        setup_bash
        setup_fish
        setup_vim
        setup_scripts
        exit 0
    fi
}

main $@
