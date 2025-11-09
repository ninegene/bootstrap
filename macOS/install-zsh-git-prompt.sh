#!/bin/bash
set -eo pipefail

# https://github.com/olivierverdier/zsh-git-prompt
mkdir -p ~/.zsh
cd ~/.zsh
git clone git@github.com:olivierverdier/zsh-git-prompt.git || true

if ! grep -q '^source ~/.zsh/zsh-git-prompt/zshrc.sh' ~/.zshrc; then
    echo "Updating ~/.zshrc to use zsh-git-prompt..."
    cat <<'DELIMITER' >>~/.zshrc

# https://github.com/olivierverdier/zsh-git-prompt
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
#GIT_PROMPT_EXECUTABLE='haskell'
source ~/.zsh/zsh-git-prompt/zshrc.sh
precmd() { print "" }
__git_super_status() {
    _status=$(git_super_status)
    _status_no_color=$(echo $_status | sed 's/\x1b\[[0-9;]*m//g')
    if [[ "$_status_no_color" == "(%{%}:%{%}|%{%}%{✔%G%}%{%})" ]]; then
        echo -n ""
    else
        echo -n $_status
    fi
}
export PROMPT='%(?.%F{green}√.%F{red}?%?)%f %F{#99E343}%n@%m%f: %F{#83B0D8}%~%f $(__git_super_status)'$'\n''%F{blue}$%f '

DELIMITER
fi

echo "Done."
