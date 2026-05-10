#!/bin/bash
set -eo pipefail

# https://github.com/ninegene/zsh-git-prompt (fork of olivierverdier/zsh-git-prompt with python3 fix)
mkdir -p ~/.zsh
cd ~/.zsh
if [[ ! -d zsh-git-prompt ]]; then
    git clone https://github.com/ninegene/zsh-git-prompt.git
else
    echo "zsh-git-prompt already cloned, pulling latest..."
    git -C zsh-git-prompt pull
fi

if ! grep -q '^source ~/.zsh/zsh-git-prompt/zshrc.sh' ~/.zshrc; then
    echo "Updating ~/.zshrc to use zsh-git-prompt..."
    cat <<'DELIMITER' >>~/.zshrc

# https://github.com/ninegene/zsh-git-prompt
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
source ~/.zsh/zsh-git-prompt/zshrc.sh
precmd() { print "" }
export PROMPT='%(?.%F{green}√.%F{red}?%?)%f %F{#99E343}%n@%m%f: %F{#83B0D8}%~%f $(git_super_status)'$'\n''%F{blue}$%f '

DELIMITER
fi

echo "Done."
