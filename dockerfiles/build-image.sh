#!/bin/bash
set -eo pipefail

SCRIPT_DIR=$(cd $(dirname $0); pwd)
SCRIPT_NAME=$(basename ${SCRIPT_DIR})

if [[ ! $1 ]]; then
    echo "USAGE: ./${SCRIPT_NAME} <image_name>" >&2
    exit 2
fi

IMAGE_NAME=$1
VERSION=$(egrep -o 'version: [0-9]+\.[0-9]+\.[0-9]+' "${SCRIPT_DIR}/${IMAGE_NAME}/Dockerfile" | sed 's/version: //')

read -r -p "Build ninegene/${IMAGE_NAME}:${VERSION} [y/n] " response
if [[ ${response} =~ ^([Yy][Ee][Ss]|[Yy])+$ ]]; then
	(set -x
	sudo docker build -t ninegene/${IMAGE_NAME}:${VERSION} ${SCRIPT_DIR}/${IMAGE_NAME}
	sudo docker build -t ninegene/${IMAGE_NAME}:latest ${SCRIPT_DIR}/${IMAGE_NAME}
	)
fi
