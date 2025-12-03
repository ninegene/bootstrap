#!/bin/bash
set -eo pipefail

if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # shellcheck disable=SC2016
    # Add Homebrew to PATH for the current session
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew is already installed. Updating Homebrew..."
    brew update
fi

# shellcheck disable=SC2016
if ! grep -q 'export PATH="/usr/local/sbin:$PATH"' ~/.zshrc; then
    echo 'export PATH="/usr/local/sbin:$PATH"' >>~/.zshrc
fi
