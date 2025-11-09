#!/bin/bash
set -eo pipefail

# Create and view interactive cheat sheets for *nix commands
# https://github.com/cheat/cheat
brew install cheat || true

# Simplified and community-driven man pages
# https://tldr.sh/
brew install tldr || true
