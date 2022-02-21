#!/bin/bash
set -eo pipefail

curdir=$(cd -- "$(dirname -- "$0")"; pwd -P)

# See: https://hexdocs.pm/phoenix/installation.htm
"$curdir"/install-elixir.sh
"$curdir"/install-nodejs.sh
mix local.hex
mix archive.install hex phx_new
