#!/bin/bash
set -e

VERSION=${1-"2.1.1"}

PKG_URL="http://dl.bintray.com/groovy/maven/groovy-binary-${VERSION}.zip"
MD5="367509550c0d21b2cf4066c6d59a4a13"

DL_DIR=${HOME}/Downloads
DL_FILE=${DL_DIR}/groovy-binary-${VERSION}.zip

mkdir -p ${DL_DIR} > /dev/null 2>&1
cd ${DL_DIR}

if [[ -f ${DL_FILE} ]]; then
    MY_MD5=$(md5sum ${DL_FILE} | tr 'A-Z' 'a-z' | egrep -o "[0-9a-z]{32}")
    if [[ ${MD5} = ${MY_MD5} ]]; then
        echo "File exists."
    else
        curl -O -L ${PKG_URL}
        echo "File downloaded."
    fi
else
    curl -O -L ${PKG_URL}
    echo "File downloaded."
fi

echo ${DL_FILE}
