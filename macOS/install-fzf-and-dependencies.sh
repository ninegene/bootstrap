#!/bin/bash

# fzf is a general-purpose command-line fuzzy finder.
# https://github.com/junegunn/fzf
brew install fzf || true
"$(brew --prefix)"/opt/fzf/install

# fd is a modern, fast alternative to the Unix find command.
brew install fd || true
open "https://github.com/sharkdp/fd"

# ripgrep (rg) is a fast, recursive, and user-friendly alternative to grep.
brew install ripgrep
open "https://github.com/BurntSushi/ripgrep"

# bat is a cat clone with syntax highlighting and Git integration.
brew install bat || true
open "https://github.com/sharkdp/bat"

# the_silver_searcher (ag) is a code-searching tool similar to ack, but faster.
brew install the_silver_searcher || true
open "https://github.com/ggreer/the_silver_searcher"

# Install Perl (needed for some fzf features)
brew install perl || true

# universal-ctags is a maintained fork of exuberant-ctags, a tool that generates
# an index (or tag) file of names found in source and header files of various
# programming languages.
brew install universal-ctags || true
open "https://github.com/universal-ctags/universal-ctags"
