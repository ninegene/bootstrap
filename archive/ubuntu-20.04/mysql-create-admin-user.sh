#!/bin/bash
set -eo pipefail

dbhost=$1
admin_user=$2
admin_pass=$3

set -u

if [[ $# -ne 3 ]]; then
    echo "Usage
    $0 <dbhost> <admin_user> <admin_pass>
    "
    exit 1
fi

sudo mysql -uroot -p \
    -h ${dbhost} \
    -e \
    "CREATE USER '${admin_user}'@'localhost' IDENTIFIED BY '${admin_pass}';GRANT ALL PRIVILEGES ON *.* TO '${admin_user}'@'localhost';GRANT ALL PRIVILEGES ON *.* TO '${admin_user}'@'%' IDENTIFIED BY '${admin_pass}';FLUSH PRIVILEGES;"
