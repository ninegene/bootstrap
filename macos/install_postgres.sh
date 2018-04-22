#!/bin/bash
set -e

brew install postgresql
# Start posgresql on boot
pg_ctl -D /usr/local/var/postgres start
brew services start postgresql
initdb /usr/local/var/postgres -E utf8
psql -V
postgres -V


echo "
The database instance 'postgres' is created automatically by defalut.
  $ psql postgres

  # List users
  postgres=# \du

Postgres doesn't directly manage users or groups. It manages roles.

To create and use new users(roles)?
- Directly execute the 'CREATE ROLE' SQL query on the database
- Use the 'createuser' utility that comes installed with Postgres (wrapper for 'CREATE ROLE')

Syntax:
  CREATE ROLE username WITH LOGIN PASSWORD 'quoted password' [OPTIONS]


postgres=# CREATE ROLE postgres WITH LOGIN PASSWORD 'postres';
postgres=# CREATE USER postgres WITH PASSWORD 'postgres';
(CREATE USER is the same as CREATE ROLE except that it imples LOGIN.)

CREATE ROLE

postgres=# \du
                                   List of roles
 Role name |                         Attributes                         | Member of
-----------+------------------------------------------------------------+-----------
 aung      | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 postgres  |                                                            | {}


postgres=# ALTER ROLE postgres CREATEDB;
ALTER ROLE

postgres=# \du
                                   List of roles
 Role name |                         Attributes                         | Member of
-----------+------------------------------------------------------------+-----------
 aung      | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 postgres  | Create DB                                                  | {}


See: https://www.postgresql.org/docs/10/static/sql-createrole.html
See: https://www.postgresql.org/docs/10/static/sql-alterrole.html


Define a new PostfreSQL user account using 'createuser' command

$ createuser --interactive joe
See: https://www.postgresql.org/docs/10/static/app-createuser.html
"
