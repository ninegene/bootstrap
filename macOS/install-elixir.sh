#!/bin/bash
set -eo pipefail

# Install Erlang and Elixir via Homebrew.
# erlang is a dependency of elixir but installing explicitly ensures
# the version is managed by brew independently.
brew install erlang elixir

set -x
# Verify the Erlang version:
erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -noshell

# Verify the Elixir version:
elixir --version
