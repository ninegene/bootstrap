#!/bin/bash
set -eu

basedir=$(dirname "$(readlink -f "$0")")

echo "Downloading ..."
# downloadedfile is absolute path
downloadedfile=$($basedir/download.sh | tail -1)
downloadeddir=$(dirname $downloadedfile)
pkgdir=$(tar -tzf $downloadedfile | head -1 | awk -F/ '{print $1}')
version=$(echo $pkgdir | egrep -o '[0-9]+\.[0-9]+\.[0-9]')

main() {
    echo "Installing ..."

    if [ -d /usr/local/$pkgdir ]; then
        echo "directory exists: /usr/local/$pkgdir"
        echo "Exiting ..."
        exit 1
    fi

    (set -x
    cd $downloadeddir
    tar xf $downloadedfile
    sudo mv $pkgdir /usr/local/
    sudo cp /usr/local/$pkgdir/ivy-${version}.jar /usr/local/ant/lib
    )
    echo "Done."
}

main
