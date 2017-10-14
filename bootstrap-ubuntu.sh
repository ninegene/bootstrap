#!/bin/bash
set -e

readonly PROG=`perl -e 'use Cwd "abs_path";print abs_path(shift)' $0`
readonly PROGDIR=$(dirname ${PROG})

./ubuntu/install-base-ubuntu-pkgs.sh
./ubuntu/install-fish.sh

./config-bash-and-fish.sh
./config-git.sh
./config-vim.sh

echo "Setting fish as default shell ..."
chsh -s /usr/bin/fish
echo "Logout and log back in to take effect."
sleep 3
