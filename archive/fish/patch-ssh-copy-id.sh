#!/bin/bash
BASE_DIR=$(cd "$(dirname "$(readlink -f "$0")")" && pwd)
cd /usr/bin
hash patch 2>/dev/null || { echo >&2 "Installing patch package."; sudo apt-get update && sudo apt-get install patch; }
patch -b < $BASE_DIR/ssh-copy-id.patch
