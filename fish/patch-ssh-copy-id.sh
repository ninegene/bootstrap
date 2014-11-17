#!/bin/bash
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd /usr/bin
hash patch 2>/dev/null || { echo >&2 "Installing patch package."; sudo apt-get update && sudo apt-get install patch; }
patch -b < $script_dir/ssh-copy-id.patch
