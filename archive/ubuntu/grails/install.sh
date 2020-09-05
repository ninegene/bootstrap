#!/bin/bash
set -e

version=${1-2.4.2}

set -u

basedir=$(dirname "$(readlink -f "$0")")

echo "Downloading ..."
# downloadedfile is absolute path
downloadedfile=$($basedir/download.sh $version | tail -1)
downloadeddir=$(dirname $downloadedfile)
pkgdir=$(unzip -v $downloadedfile | head -4 | tail -1 | egrep -o 'grails-[0-9.]+')

main() {
    echo "Installing ..."

    if [ -d /usr/local/$pkgdir ]; then
        echo "directory exists: /usr/local/$pkgdir"
        echo "Exiting ..."
        exit 1
    fi

    (set -x
    cd $downloadeddir
    unzip -q $downloadedfile
    sudo mv $pkgdir /usr/local/
    )

    echo "Done."
}

main
