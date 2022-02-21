#!/bin/bash
set -eo pipefail

set -x
mkdir -p ~/.zsh_functions
cd ~/.zsh_functions
git clone git@github.com:olivierverdier/zsh-git-prompt.git

echo "
# See: https://github.com/olivierverdier/zsh-git-prompt
_git_super_status(){
    if git status >/dev/null 2>&1; then
        git_super_status
    fi
}
ZSH_THEME_GIT_PROMPT_CACHE=1
source ~/.zsh_functions/zsh-git-prompt/zshrc.sh
PROMPT='%B%~%b \$(git_super_status) $ '
" >> ~/.zshrc
