#!/bin/bash
set -eo pipefail

# fzf is a general-purpose command-line fuzzy finder.
# See: https://github.com/junegunn/fzf
[[ -d ~/.fzf ]] || git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
