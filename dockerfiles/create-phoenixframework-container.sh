#!/bin/bash
set -eo pipefail

SCRIPT_DIR=$(cd $(dirname $0); pwd)
SCRIPT_NAME=$(basename ${SCRIPT_DIR})

# if [[ ! $1 && ! $2 && ! $3 ]]; then
if [[ ! $1 ]]; then
    echo "USAGE: ./${SCRIPT_NAME} <container_name> [http_port] [https_port]" >&2
    exit 2
fi

CONT_NAME=$1
EXPOSED_HTTP_PORT=${2:-"8000"}
EXPOSED_HTTPS_PORT=${3:-"4430"}

DOCKER_IMAGE="ninegene/phoenixframework"

set -x

sudo mkdir -p /containers/${CONT_NAME}

sudo docker run -d --restart=unless-stopped \
	--name ${CONT_NAME} --hostname ${CONT_NAME} \
	-v /containers/${CONT_NAME}:/root/server \
	-v /etc/localtime:/etc/localtime:ro \
	-v /etc/timezone:/etc/timezone:ro \
	-p ${EXPOSED_HTTP_PORT}:${EXPOSED_HTTP_PORT} \
	-p ${EXPOSED_HTTPS_PORT}:${EXPOSED_HTTPS_PORT} \
	${DOCKER_IMAGE} \
	/sbin/my_init
