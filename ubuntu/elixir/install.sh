#!/bin/bash
set -e

cd /tmp

# https://www.howtodojo.com/2017/07/install-erlang-ubuntu-16-04/
# wget https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc
# sudo apt-key add erlang_solutions.asc
# echo "deb http://binaries.erlang-solutions.com/debian xenial contrib" | sudo tee /etc/apt/sources.list.d/erlang-solutions.list

# https://hexdocs.pm/phoenix/installation.html#erlang-18-or-later
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
sudo dpkg -i erlang-solutions_1.0_all.deb

sudo apt-get update
sudo apt-get install esl-erlang

sudo apt-get install elixir
