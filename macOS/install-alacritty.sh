#!/bin/bash
set -eo pipefail

version="0.10.1"

(
    set -x
    cd /tmp
    curl -L "https://github.com/alacritty/alacritty/releases/download/v${version}/Alacritty-v${version}.dmg" \
        -o Alacritty.dmg

    open Alacritty.dmg
)

printf "
See: https://github.com/alacritty/alacritty/blob/master/INSTALL.md#zsh

To install the completions for zsh:

    mkdir -p \${ZDOTDIR:-~}/.zsh_functions
    echo -e '\n# See: https://github.com/alacritty/alacritty/blob/master/INSTALL.md#zsh' >> \${ZDOTDIR:-~}/.zshrc
    echo -e 'fpath+=\${ZDOTDIR:-~}/.zsh_functions\n' >> \${ZDOTDIR:-~}/.zshrc
    cp /Applications/Alacritty.app/Contents/Resources/completions/_alacritty \${ZDOTDIR:-~}/.zsh_functions/_alacritty


Download default config file:

    mkdir ~/.config/alacritty
    curl -L \"https://raw.githubusercontent.com/alacritty/alacritty/master/alacritty.yml\" -o ~/.config/alacritty/alacritty.yml


Modify config file:

    vim ~/.config/alacritty/alacritty.yml
"

