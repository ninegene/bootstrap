#!/bin/bash
set -eo pipefail

curdir=$(dirname "$(readlink -f "$0")")

dbhost=$1
dbname=$2
dbuser=$3
dbpass=$4
backupdir=$5

set -u

if [[ $# -ne 5 ]]; then
    echo "Usage
    $0 <dbhost> <dbname> <dbuser> <dbpass> <backupdir>
    "
    exit 1
fi

if [[ ! -e ${backupdir} ]]; then
    mkdir -p ${backupdir}
fi

if [[ ! -d ${backupdir} ]]; then
    echo "${backupdir} is not directory!"
    exit 1
fi

backupfile="${backupdir}/${dbname}-$(date +%F_%s).sql"

mysqldump --add-drop-table -h${dbhost} -u${dbuser} -p${dbpass} ${dbname} > ${backupfile}
gzip ${backupfile}

echo "Backup to ${backupfile}.gz"
