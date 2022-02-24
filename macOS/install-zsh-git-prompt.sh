#!/bin/bash
set -eo pipefail

curdir=$(cd "$(dirname "$0")"; pwd -P)

set -x
"$curdir"/install-haskell-tool-stack.sh

mkdir -p ~/.zsh_functions
cd ~/.zsh_functions

if [[ ! -d zsh-git-prompt ]]; then
    git clone git@github.com:olivierverdier/zsh-git-prompt.git
else
    cd zsh-git-prompt
    git pull
    cd -
fi

cd zsh-git-prompt
stack setup
stack build
stack install

echo "
# See: 
# https://github.com/olivierverdier/zsh-git-prompt
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
GIT_PROMPT_EXECUTABLE='haskell'
source ~/.zsh_functions/zsh-git-prompt/zshrc.sh
precmd() { print \"\" }
_git_super_status() {
    g_status=\$(git_super_status)
    [[ \$g_status ]] && echo -n \"\$g_status \"
}
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %{\$fg[cyan]%}%1~%{\$reset_color%} \$(_git_super_status)%B%F{111}$%f%b '

" >> ~/.zshrc
set +x

echo "
Added prompt to ~/.zshrc and source the ~/.zshrc to see the changes:
    $ source ~/.zshrc
"

