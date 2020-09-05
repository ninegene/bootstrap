#!/bin/bash
set -ex

# Based on: http://www.phoenixframework.org/docs/installation
brew install elixir
brew install nodejs # for build tool brunch.io
mix local.hex
mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
