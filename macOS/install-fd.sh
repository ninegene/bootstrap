#!/bin/bash
set -eo pipefail

# fd is a modern, fast alternative to the Unix find command. 
# https://github.com/sharkdp/fd
brew install fd
open "https://github.com/sharkdp/fd"