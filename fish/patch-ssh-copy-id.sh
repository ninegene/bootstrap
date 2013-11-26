#!/bin/bash
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd /usr/bin
patch < $script_dir/ssh-copy-id.patch
