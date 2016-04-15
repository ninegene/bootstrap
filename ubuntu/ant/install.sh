#!/bin/bash
set -eu

basedir=$(dirname "$(readlink -f "$0")")

echo "Downloading ..."
# downloadedfile is absolute path
downloadedfile=$($basedir/download.sh | tail -1)
downloadeddir=$(dirname $downloadedfile)
pkgdir=$(tar -tzf $downloadedfile | head -1 | awk -F/ '{print $1}')

main() {
    echo "Installing ..."

    if [ -d /usr/local/$pkgdir ]; then
        echo "directory exists: /usr/local/$pkgdir"
        echo "Exiting ..."
        exit 1
    fi

    (set -x; cd $downloadeddir)
    (set -x; tar xf $downloadedfile)
    (set -x; sudo mv $pkgdir /usr/local/)
    (set -x; sudo ln -sf /usr/local/$pkgdir /usr/local/ant)
    (set -x; sudo ln -sf /usr/local/ant/bin/ant /usr/bin/ant)
    echo "Done."
}

main
