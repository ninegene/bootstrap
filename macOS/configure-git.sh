#!/bin/bash
set -eo pipefail

git_config_global_settings() {
    echo "Configuring Git global settings..."
    local username
    local useremail
    username=$(whoami)
    useremail="$username@$(hostname)"

    if ! cat ~/.gitconfig | grep -EA 4 '\[user\]' | egrep '^\sname =' >/dev/null; then
        (
            set -x
            git config --global user.name "$username"
        )
    fi

    if ! cat ~/.gitconfig | grep -EA 4 '\[user\]' | egrep '^\semail =' >/dev/null; then
        (
            set -x
            git config --global user.email "$useremail"
        )
    fi

    # With `core.autocrlf` set to `input`:
    # 1. On checkout (Git → working directory): Line endings are left as-is (LF remains LF)
    # 2. On commit (working directory → Git): CRLF line endings are converted to LF
    # 3. Result: Ensures the repository always contains LF line endings, regardless of what's in your working directory
    git config --global core.autocrlf input

    # Pushes current branch to its upstream: When you run `git push`, it only pushes the branch you're currently on to its matching upstream branch
    # - Requires matching names: The local and remote branch must have the same name (e.g., `feature` → `origin/feature`)
    # - Safe and predictable: You won't accidentally push multiple branches or branches to different names
    git config --global push.default simple

    # Reuse recorded Resolution
    # - When a conflict occurs and you resolve it, Git stores the before/after state
    # - Next time the same conflict pattern appears, Git applies the recorded resolution automatically
    # - You can still review and modify the auto-resolved conflicts before committing
    git config --global rerere.enabled true

    git config --global core.editor vim
}

git_config_aliases() {
    echo "Configuring Git aliases..."
    git config --global alias.aliases "!git config --get-regexp 'alias.*' | colrm 1 6 | sed 's/[ ]/ = /'"

    git config --global alias.me "!git config user.name && git config user.email"
    git config --global alias.user "config user.name"
    git config --global alias.email "config user.email"

    git config --global alias.st "status --short --branch"
    git config --global alias.br "branch"

    git config --global alias.co "checkout"
    git config --global alias.cob "checkout -b"

    git config --global alias.unstage 'reset HEAD --'

    git config --global alias.aa "!git add --all"

    git config --global alias.ci "commit -m"
    git config --global alias.amend "commit --amend"

    git config --global alias.d "diff"
    git config --global alias.dh "diff HEAD"
    git config --global alias.ds "diff --staged" # Same as "diff --cached"

    # Show last commit
    git config --global alias.last '!git ll -1 HEAD'

    # Show commits in one per line (abbrev commit, short date, tag, message, author)
    git config --global alias.ls "log --abbrev-commit --date=short --pretty=format:'%C(yellow)%h %ad%Creset%Cred%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
    git config --global alias.ll "!git ls --name-status"

    # concise with graph
    git config --global alias.lg "log --oneline --decorate --all --graph"

    git config --global alias.pr "!git pull -v --rebase && git changes"

    # Show the commits that changed 'config/application.properties', including those commits that
    # occurred before the file was given its present name. (Show file commit history)
    # $ git f application.properties
    git config --global alias.fc "!git ls --follow"

    # Show file commit history with diffs
    git config --global alias.fh "!git ls -u"

    # Show commits in local timezone
    git config --global alias.loglocal "log --date=local"

    # Find file in the repository (case insensitive)
    git config --global alias.ff "!git ls-files | grep -i"
}

git_config_global_settings
git_config_aliases
echo "Git configuration completed."
