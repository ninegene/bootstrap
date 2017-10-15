#!/bin/bash
set -e

readonly PROG=`perl -e 'use Cwd "abs_path";print abs_path(shift)' $0`
readonly PROGDIR=$(dirname ${PROG})
BASEDIR=${PROGDIR}/..

${BASEDIR}/ubuntu/install-base-ubuntu-pkgs.sh
${BASEDIR}/ubuntu/fish/install.sh

${BASEDIR}/config-shell.sh
${BASEDIR}/git/config-git.sh
${BASEDIR}/vim/config-vim.sh

echo "Setting fish as default shell ..."
chsh -s /usr/bin/fish
echo "Logout and log back in to take effect."
sleep 3
