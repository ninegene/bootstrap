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

sudo mkdir -p /containers/${CONT_NAME}/var/www/html
sudo mkdir -p /containers/${CONT_NAME}/var/log/apache2
sudo mkdir -p /containers/${CONT_NAME}/etc/apache2/sites-available
sudo mkdir -p /containers/${CONT_NAME}/etc/apache2/sites-enabled
sudo mkdir -p /containers/${CONT_NAME}/scripts

sudo docker run -d --restart=unless-stopped \
	--name ${CONT_NAME} --hostname ${CONT_NAME} \
	-v /containers/${CONT_NAME}/var/www:/var/www \
	-v /containers/${CONT_NAME}/var/log/apache2:/var/log/apache2 \
	-v /containers/${CONT_NAME}/etc/apache2/sites-availables:/etc/apache2/sites-availables \
	-v /containers/${CONT_NAME}/etc/apache2/sites-enabled:/etc/apache2/sites-enabled \
	-v /containers/${CONT_NAME}/scripts:/root/scripts \
	-v /etc/localtime:/etc/localtime:ro \
	-v /etc/timezone:/etc/timezone:ro \
	-p ${EXPOSED_HTTP_PORT}:80 \
	-p ${EXPOSED_HTTPS_PORT}:443 \
	${MORE_DOCKER_OPTIONS} \
	${DOCKER_IMAGE} \
	/sbin/my_init
