#!/bin/bash
set -eo pipefail

set -x
if ! type stack >/dev/null; then
    curl -sSL https://get.haskellstack.org/ | sh
else
    stack upgrade
fi

