#!/bin/bash
set -eo pipefail

# Download and install Node.js:
brew install node@24

# Verify the Node.js version:
node -v

# Verify npm version:
npm -v
