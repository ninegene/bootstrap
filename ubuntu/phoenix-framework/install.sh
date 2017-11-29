#!/bin/bash
set -e

readonly PROG=`perl -e 'use Cwd "abs_path";print abs_path(shift)' $0`
readonly PROGDIR=$(dirname ${PROG})

${PROGDIR}/../elixir/install.sh
${PROGDIR}/../nodejs/install.sh

sudo npm install -g brunch

echo 'y' | mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez
echo "For more info, see: https://hexdocs.pm/phoenix/installation.html"

