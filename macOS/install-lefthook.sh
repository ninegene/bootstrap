#!/bin/bash
set -eo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Installing Lefthook..."
brew install lefthook

echo "Installing Lefthook hooks into repo..."
lefthook install -d "$REPO_ROOT"

echo "Lefthook installation completed."
