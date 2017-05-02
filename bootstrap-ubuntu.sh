#!/bin/bash
set -e

readonly PROG=`perl -e 'use Cwd "abs_path";print abs_path(shift)' $0`
readonly PROGDIR=$(dirname ${PROG})

./ubuntu/install-base-ubuntu-pkgs.sh
./config-git.sh
./config-vim.sh
./config-bash-and-fish.sh
