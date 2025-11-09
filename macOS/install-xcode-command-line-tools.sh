#!/bin/bash
set -eo pipefail

# This installs Apple's command-line developer tools (compilers, git, etc.) without needing the full Xcode app.
xcode-select --install || true

echo "XCode installation path:"
xcode-select -p
