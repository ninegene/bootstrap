#!/bin/bash

set -eo pipefail

# https://github.com/magicmonty/bash-git-prompt

if [[ -d ~/.bash-git-prompt ]]; then
    cd ~/.bash-git-prompt
    git pull
else
    git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
fi

if ! grep -q '^source ~/.bash-git-prompt/gitprompt.sh' ~/.bashrc; then
    echo '
source ~/.bash-git-prompt/gitprompt.sh
' >> ~/.bashrc
fi

