#!/bin/bash
set -eo pipefail

# Syntax Checker for Shell Scripts
# https://github.com/koalaman/shellcheck?tab=readme-ov-file#installing
brew install shellcheck || true
open "https://github.com/koalaman/shellcheck"

# Shell Formatter
# https://github.com/mvdan/sh?tab=readme-ov-file#shfmt
brew install shfmt || true
open "https://github.com/mvdan/sh"
