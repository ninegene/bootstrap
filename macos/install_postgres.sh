#!/bin/bash
set -e

brew install postgresql
brew services start postgresql
initdb /usr/local/var/postgres -E utf8
psql -V
