#!/bin/bash
set -eo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# zsh-git-prompt
# https://github.com/ninegene/zsh-git-prompt (fork of olivierverdier/zsh-git-prompt with python3 fix)
echo "Installing zsh-git-prompt..."
mkdir -p ~/.zsh
if [[ ! -d ~/.zsh/zsh-git-prompt ]]; then
    git clone https://github.com/ninegene/zsh-git-prompt.git ~/.zsh/zsh-git-prompt
else
    echo "zsh-git-prompt already cloned, pulling latest..."
    git -C ~/.zsh/zsh-git-prompt pull
fi

echo "Updating ~/.zshrc with zsh-git-prompt and prompt..."
perl -0pi -e 's/\n# https:\/\/github\.com\/ninegene\/zsh-git-prompt\n.*?export PROMPT=.*?\n\n//s' ~/.zshrc
cat <<'DELIMITER' >>~/.zshrc

# https://github.com/ninegene/zsh-git-prompt
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
source ~/.zsh/zsh-git-prompt/zshrc.sh
export PROMPT='%(?.%F{green}√.%F{red}?%?)%f %F{#83B0D8}%~%f $(git_super_status)
%F{blue}$%f '

DELIMITER

# zsh aliases
ZSH_ALIASES_SOURCE="source $REPO_ROOT/macOS/zsh_aliases"
echo "Configuring zsh_aliases..."
if [ -f ~/.zshrc ]; then
    perl -0pi -e 's|^source .*/bootstrap/macOS/zsh_aliases$||mg' ~/.zshrc
fi
if ! grep -Fxq "$ZSH_ALIASES_SOURCE" ~/.zshrc; then
    echo "Updating ~/.zshrc to load zsh_aliases..."
    echo "$ZSH_ALIASES_SOURCE" >>~/.zshrc
fi

# screenrc
echo "Configuring .screenrc..."
SCREENRC_TARGET="$REPO_ROOT/macOS/screenrc"
if [ "$(readlink ~/.screenrc)" != "$SCREENRC_TARGET" ]; then
    ln -vsf "$SCREENRC_TARGET" ~/.screenrc
fi

echo "Zsh configuration completed."
