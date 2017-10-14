#!/bin/bash
set -eo pipefail

SCRIPT_DIR=$(cd $(dirname $0); pwd)
SCRIPT_NAME=$(basename ${SCRIPT_DIR})

if [[ ! $1 ]]; then
    echo "USAGE: ./${SCRIPT_NAME} <container_name>" >&2
    exit 2
fi

CONT_NAME=$1
shift
MORE_DOCKER_OPTIONS=$@

EXPOSED_HTTP_PORT="80"
EXPOSED_HTTPS_PORT="443"
DOCKER_IMAGE="ninegene/apache2"

set -x
sudo mkdir -p /var/www/html
sudo mkdir -p /etc/letsencrypt
sudo chown ${USER}:${USER} /var/www/html

sudo docker run -d --restart=unless-stopped \
	--name ${CONT_NAME} --hostname ${CONT_NAME} \
	-v /var/www/html:/var/www/html \
	-v /etc/letsencrypt:/etc/letsencrypt \
	-p ${EXPOSED_HTTP_PORT}:80 \
	-p ${EXPOSED_HTTPS_PORT}:443 \
	${MORE_DOCKER_OPTIONS} \
	${DOCKER_IMAGE} \
	/sbin/my_init
