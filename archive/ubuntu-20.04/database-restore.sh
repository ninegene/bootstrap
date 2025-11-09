#!/bin/bash
set -eo pipefail

curdir=$(dirname "$(readlink -f "$0")")

dbhost=$1
dbname=$2
dbuser=$3
dbpass=$4
dbfile=$5

set -u

if [[ $# -ne 5 || ! ${dbfile} =~ (.sql|.sql.gz)$ ]]; then
    echo "Usage:
    $0 <dbhost> <dbname> <dbuser> <dbpass> path/to/filename.sql
    $0 <dbhost> <dbname> <dbuser> <dbpass> path/to/filename.sql.gz
    "
    exit 1
fi

if [[ ! -f ${dbfile} ]]; then
    echo "file not found: ${dbfile}"
    exit 1
fi

if [[ ${dbfile} =~ .sql.gz$ ]]; then
    gzfile=${dbfile}
    sqlfile=${gzfile%%.gz}
    gunzip ${gzfile}
elif [[ ${dbfile} =~ .sql$ ]]; then
    sqlfile=${dbfile}
fi

mysql -h${dbhost} -u${dbuser} -p${dbpass} ${dbname} < ${sqlfile}
