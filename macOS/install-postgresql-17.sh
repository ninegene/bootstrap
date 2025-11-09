#!/bin/bash
set -eo pipefail

# See: https://postgresapp.com/documentation/install.html

# Postgres.app version
app_version="2.8.5"
major_version=17

# https://postgresapp.com/downloads.html
pushd /tmp
curl -L "https://github.com/PostgresApp/PostgresApp/releases/download/v$app_version/Postgres-${app_version}-${major_version}.dmg" \
    -o Postgres.app.dmg
popd >/dev/null

sudo mkdir -p /etc/paths.d
echo /Applications/Postgres.app/Contents/Versions/latest/bin | sudo tee /etc/paths.d/postgresapp >/dev/null

if ! grep -q '^PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"' ~/.zshrc; then
    echo 'PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"' >>~/.zshrc
fi

open Postgres.app.dmg
echo "
    1.  Move to Applications folder   ➜   Double Click

    2. Open "Postgres.app" and click "Initialize" to create a new server

More info: https://postgresapp.com/
"
