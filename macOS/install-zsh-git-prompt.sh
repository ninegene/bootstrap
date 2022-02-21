#!/bin/bash
set -eo pipefail

set -x
cd ~/.config
git clone git@github.com:olivierverdier/zsh-git-prompt.git

echo "
# See: https://github.com/olivierverdier/zsh-git-prompt
source ~/.config/zsh-git-prompt/zshrc.sh
PROMPT='%B%~%b \$(git_super_status) $ '
" >> ~/.zshrc
