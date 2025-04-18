#!/bin/bash
set -eo pipefail

usage() {
    echo "
    Usage:
      $0 <timezone>

    Example:
      $0 America/Los_Angeles
"
}

timezone=$1

if [[ -z ${timezone} ]]; then
    usage
    exit 1
fi

sudo timedatectl set-timezone "${timezone}"
