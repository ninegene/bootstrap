#!/bin/bash
set -e

USER_NAME=${1-$(whoami)}
EMAIL=${2-${USER_NAME}@$(hostname)}

main() {

    set -x

    ## configs ##

    git config --global user.name "$USER_NAME"
    git config --global user.email "$EMAIL"

    git config --global push.default simple

    git config --global core.autocrlf input
    git config --global core.editor vi

    git config --global diff.tool diffuse
    if [[ $(uname -s) = 'Darwin' ]]; then
        git config --global diff.tool opendiff
    fi

    git config --global alias.user "config user.name"
    git config --global alias.email "config user.email"
    git config --global alias.me "config user.email"

    [[ ! -f $HOME/.gitignore_global ]] && touch $HOME/.gitignore_global
    git config --global core.excludesfile $HOME/.gitignore_global

    git config --global alias.aliases "!git config --get-regexp 'alias.*' | colrm 1 6 | sed 's/[ ]/ = /'"


    ## git status ##

    git config --global alias.st "status --short --branch"


    ## git checkout ##

    git config --global alias.co "checkout"
    git config --global alias.cob "checkout -b"


    ## git branch ##

    git config --global alias.br "branch"


    ## git remote ##

    git config --global alias.r "remote show origin"


    ## git pull ##

    # May not work correctly if there is no changes to stash and will pop out old stash
    #git config --global alias.update "!git stash save && git pull -v --rebase && git stash pop && git changes"

    git config --global alias.pr "!git pull -v --rebase && git changes"


    ## git difftool ##

    git config --global alias.dt "difftool"


    ## git diff ##

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

    # Compare your working directory and the index (staging area for the next commit).
    git config --global alias.d "diff"
    git config --global alias.dw "diff --word-diff=color"

    # Compare your working directory and the latest commit.
    # Compare a specific file(s) in your working directory and the latest commit.
    # $ git dh -- path/to/files
    # $ git dh -- path/**/*/files
    git config --global alias.dh "diff HEAD"
    git config --global alias.dwh "diff --word-diff=color HEAD"

    # Compare the index (staging area for the next commit) and the latest commit.
    git config --global alias.ds "diff --staged" # Same as "diff --cached"
    git config --global alias.dws "diff --word-diff=color --staged"


    ## git reset ##

    # Unstage file or remove file from the index (staging area)
    git config --global alias.unstage 'reset HEAD --'

    # Throw away all changes you made in your working directory.
    # Commit first and reset hard to last commit so that you can recover with 'git reflog' if needed
    # A better way to handle 'git reset HEAD --hard'
    git config --global alias.rh "!git add --all && git commit --allow-empty -qm 'reset hard commit' && git reset ${1-HEAD} --hard"

    # Reset last commit and keeps all the last commit changes in your working directory
    git config --global alias.rl "reset HEAD~1 --mixed"

    # Resetting to origin/HEAD. (E.g. Undo 'git resetlast'.)
    #git config --global alias.resethead "reset origin/HEAD"


    ## git commit ##

    git config --global alias.ci "commit -m"

    # Commit all changes (adds, modifies, and removes index entries to match the working tree)
    git config --global alias.cia "!git add --all && git commit -m"

    # Commit staged changes (modifires and removes index entries to match the working tree but adds no new files)
    git config --global alias.ciu "!git add --update && git commit -m"

    # Modify last commit
    git config --global alias.amend "commit --amend"

    ## git log ##

    # Show commits in one per line (abbrev commit, short date, tag, message, author)
    git config --global alias.ls "log --abbrev-commit --date=short --pretty=format:'%C(yellow)%h %ad%Creset%Cred%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
    git config --global alias.ll "!git ls --name-status"

    # Show last commit
    git config --global alias.last '!git ll -1 HEAD'

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
    git config --global alias.fh "!git ls --follow"

    # Show file commit history with diffs
    git config --global alias.fc "!git ls -u"

    # Show commits in local timezone
    git config --global alias.locallog "log --date=local"

    ## grep ##

    # Case insensitive search text
    #git config --global alias.grep "grep -i"

    ## ls-files ##

    # Find file name/path
    git config --global alias.fname "!git ls-files | grep -i"

    ## cat-file ##

    git config --global alias.type "cat-file -t"
    git config --global alias.dump "cat-file -p"

    set +x

    echo "Done setting up git global configs."

    # References
    # http://git-scm.com/book/en/v2/Git-Basics-Git-Aliases
    # https://git.wiki.kernel.org/index.php/Aliases
    # http://haacked.com/archive/2014/07/28/github-flow-aliases/
    # http://durdn.com/blog/2012/11/22/must-have-git-aliases-advanced-examples/
}

main
