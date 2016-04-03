#!/bin/bash
set -e

imagename=${1-ninegene/ubuntubase}
version=$(egrep -m 1 -o 'version: [0-9]+\.[0-9]+\.[0-9]+' "$basedir/$imagename/Dockerfile" | sed 's/version: //')
basedir=$(dirname "$(readlink -f "$0")")

(set -x; $basedir/$imagename/prebuild.sh)

(set -x; docker build -t $imagename:$version $basedir/$imagename)
(set -x; docker build -t $imagename:latest $basedir/$imagename)
