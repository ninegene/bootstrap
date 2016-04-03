#!/bin/bash
set -e

version=${1-1.0.0}

curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
(set -x; sudo apt-get install git-lfs=${version})
