#!/bin/bash
set -eo pipefail

# See: https://postgresapp.com/documentation/install.html

# Postgres.app version
app_version="2.8.5"
major_version=17

(
	set -x
	# https://postgresapp.com/downloads.html
	cd /tmp
	curl -L "https://github.com/PostgresApp/PostgresApp/releases/download/v$app_version/Postgres-${app_version}-${major_version}.dmg" \
		-o Postgres.app.dmg

	open Postgres.app.dmg
)

echo "
    1.  Move to Applications folder   ➜   Double Click

    2. Click \"Initialize\" to create a new server

    3. Configure your \$PATH to use the included command line tools (optional):

       sudo mkdir -p /etc/paths.d
       echo /Applications/Postgres.app/Contents/Versions/latest/bin | sudo tee /etc/paths.d/postgresapp

       echo 'PATH=\"$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin\"' >> ~/.zshrc

More info: https://postgresapp.com/
"
