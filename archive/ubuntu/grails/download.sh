#!/bin/bash
set -e

version=${1-2.4.2}
pkgfile="grails-${version}.zip"
pkgurl="http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/$pkgfile"
md5="ae97dc5c6958027fdffd5b0fe5c61372"

# get from environment variable 'UBUNTU_BOOTSTRAP_DOWNLOAD_DIR' if set
dldir=${UBUNTU_BOOTSTRAP_DOWNLOAD_DIR:-/tmp}
mkdir -p $dldir > /dev/null 2>&1

download() {
    local url=$1
    local file=$2

    if [[ $file == *.md5 ]]; then
        wget -qO- $url | grep $pkgfile | egrep -o '[a-zA-Z0-9]{32}' > $file
    elif [[ -z $file ]]; then
        wget -c --backups=1 $url
    else
        wget -c --backups=1 -O $file $url
    fi
}

getmd5() {
    local md5file=$1
    echo $(cat $md5file | tr 'A-Z' 'a-z' | egrep -o '[a-zA-Z0-9]{32}')
}

comparemd5() {
    local file1=$1
    local file2=$2
    local f1md5=$(getmd5 $file1)
    local f2md5=$(getmd5 $file2)
    echo $f1md5 $file1
    echo $f2md5 $file2
    if [[ $f1md5 != $f2md5 ]]; then
        return 1
    fi
}

main() {
    echo "Download directory is $dldir"
    cd $dldir

    [[ -f ${pkgfile}.md5 ]] && rm ${pkgfile}.md5
    [[ -f ${pkgfile}.md5sum ]] && rm ${pkgfile}.md5sum

    if [[ -f $pkgfile ]]; then
        echo "file exists: $pkgfile"
        echo $md5 > ${pkgfile}.md5
        md5sum $pkgfile > ${pkgfile}.md5sum
        (set +e
        comparemd5 ${pkgfile}.md5 ${pkgfile}.md5sum
        if [[ $? == 1 ]]; then
            download $pkgurl $pkgfile
            md5sum $pkgfile > ${pkgfile}.md5sum
        fi
        )
    else
        download $pkgurl $pkgfile
        md5sum $pkgfile > ${pkgfile}.md5sum
    fi

    echo $dldir/$pkgfile
}

main
