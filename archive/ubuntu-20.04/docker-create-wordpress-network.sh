#!/bin/bash
set -eo pipefail

set -x
sudo docker network create -d bridge --subnet 192.168.10.0/24 wordpress-network
