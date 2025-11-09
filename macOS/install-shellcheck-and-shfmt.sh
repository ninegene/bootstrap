#!/bin/bash
set -eo pipefail

# Syntax Checker for Shell Scripts
# https://github.com/koalaman/shellcheck?tab=readme-ov-file#installing
brew install shellcheck

# Shell Formatter
# https://github.com/mvdan/sh?tab=readme-ov-file#shfmt
# https://formulae.brew.sh/formula/shfmt
brew install shfmt
