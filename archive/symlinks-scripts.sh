#!/bin/bash
set -e

readonly PROG=`perl -e 'use Cwd "abs_path";print abs_path(shift)' $0`
readonly PROGDIR=$(dirname ${PROG})
readonly SCRIPTS_DIR=${PROGDIR}/scripts

backup() {
    local file=${1}

    if [[ -L ${file} ]]; then
        rm "${file}"
        echo "Deleted symlink ${file}"
    elif [[ -f ${file} ]]; then
        local bakfile=${file}.$(md5 "${file}").bak
        mv "${file}" "${bakfile}"
        echo "Backed up file to ${bakfile}"
    elif [[ -d ${file} ]]; then
        local bakdir=${file}.$(date +%Y%m%d%H%M%S).bak
        mv "${file}" "${bakdir}"
        echo "Backed up dir to ${bakdir}"
    fi
}

symlink() {
    local src=${1}
    local dst=${2}

    backup "${dst}"
    ln -s "${src}" "${dst}"
    echo "Created symlink ${dst}"
}


main() {
    mkdir -p ${HOME}/bin
    for file in ${SCRIPTS_DIR}/*
    do
	    symlink ${file} ${HOME}/bin/$(basename ${file})
    done
}

main
