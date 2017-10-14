#!/bin/sh
set -e

CURDIR=$(dirname "$(readlink -f "$0")")

curl -sSL https://get.docker.com/ -o $CURDIR/docker.sh
cat $CURDIR/docker.sh
cat >&2 <<-'EOF'
	You may press Ctrl+C now to abort executing of the above script.
EOF
(set -x; sleep 10)
chmod a+x $CURDIR/docker.sh
$CURDIR/docker.sh
