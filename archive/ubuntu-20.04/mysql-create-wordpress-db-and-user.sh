#!/bin/bash
set -eo pipefail

read -p "DBNAME: " DBNAME
DBUSER=wordpress
DBPASS=wordpress
ALLOW_HOSTS="%"

set -x
mysql -uroot --protocol TCP -e "CREATE DATABASE ${DBNAME} DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
mysql -uroot --protocol TCP -e "GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON ${DBNAME}.* TO ${DBUSER}@'${ALLOW_HOSTS}' IDENTIFIED BY '${DBPASS}'; FLUSH PRIVILEGES;"
