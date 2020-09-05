#!/bin/bash
set -e

config_global_settings() {
    local username=$(whoami)
    local useremail=$username@$(hostname)

    if ! cat ~/.gitconfig | egrep -A 4 '\[user\]' | egrep '^\sname ='>/dev/null; then
        (set -x; git config --global user.name "$username")
    fi

    if ! cat ~/.gitconfig | egrep -A 4 '\[user\]' | egrep '^\semail ='>/dev/null; then
        (set -x; git config --global user.email "$useremail")
    fi

    set -x
    git config --global push.default simple
    git config --global core.autocrlf input

    # for git v.1.8.4 and earlier
    git config --global color.ui true

    # Reuse recorded Resolution
    # Records all fixes to merge conflicts
    # and Reuses them automatically if the same conflict recurs
    # Particularly useful when cherry picking to multiple branches or constantly rebasing
    git config --global rerere.enabled true

    git config --global core.editor vim

    [[ ! -f $HOME/.gitignore_global ]] && touch $HOME/.gitignore_global
    git config --global core.excludesfile $HOME/.gitignore_global
}

config_aliases() {
    git config --global alias.me "!git config user.name && git config user.email"
    git config --global alias.user "config user.name"
    git config --global alias.email "config user.email"
    git config --global alias.aliases "!git config --get-regexp 'alias.*' | colrm 1 6 | sed 's/[ ]/ = /'"

    git config --global alias.s "status --short"
    git config --global alias.st "status --short --branch"
    git config --global alias.br "branch"

    git config --global alias.co "checkout"
    git config --global alias.cob "checkout -b"

    git config --global alias.unstage 'reset HEAD --'

    git config --global alias.aa "!git add --all"

    git config --global alias.ci "commit -m"
    git config --global alias.cia "!git add --all && git commit -m"
    git config --global alias.amend "commit --amend"

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

    git config --global alias.d "diff"
    git config --global alias.dh "diff HEAD"
    git config --global alias.ds "diff --staged" # Same as "diff --cached"

    git config --global alias.dw "diff --word-diff=color"
    git config --global alias.dhw "diff --word-diff=color HEAD"
    git config --global alias.dsw "diff --word-diff=color --staged"

    # Show last commit
    git config --global alias.last '!git ll -1 HEAD'

    # Show commits in one per line (abbrev commit, short date, tag, message, author)
    git config --global alias.ls "log --abbrev-commit --date=short --pretty=format:'%C(yellow)%h %ad%Creset%Cred%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
    git config --global alias.ll "!git ls --name-status"

    # concise with graph
    git config --global alias.lg "log --oneline --decorate --all --graph"

    # Show new commits created by the last command (typically after a 'git pull')
    # Example:
    # $ git changes
    # $ git changes origin/master
    git config --global alias.changes "!sh -c 'git ll $1@{1}..$1@{0} $@'"

    git config --global alias.pr "!git pull -v --rebase && git changes"

    # Show all commits since version v2.2.11 that changed any file in the 'src' or 'test' subdirectories
    # (Use 'git tag' to see all version tag)
    # $ git log v2.2.11.. src test

    # Show the commits that are in the "dev" branch but not yet in the 'master' branch,
    # along with the list of paths each commit modifies.
    # $ git log --name-status master..dev
    # $ git ll master..dev

    # Show the commits that changed 'config/application.properties', including those commits that
    # occurred before the file was given its present name. (Show file commit history)
    # $ git f application.properties
    git config --global alias.fc "!git ls --follow"

    # Show file commit history with diffs
    git config --global alias.fh "!git ls -u"

    # Show commits in local timezone
    git config --global alias.locallog "log --date=local"

    # Case insensitive search text
    git config --global alias.grep "grep -i"

    # Find file name/path
    git config --global alias.fname "!git ls-files | grep -i"
}


main() {
    config_global_settings
    config_aliases
}

${1-main}
