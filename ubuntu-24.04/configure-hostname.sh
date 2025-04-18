#!/bin/bash
set -eo pipefail

usage() {
    echo "
    Usage:
      $0 <domain_name>

    Example:
      $0 myserver.mydomain.com
    "
}

domain_name=$1

if [[ -z ${domain_name} ]]; then
    usage
    exit 1
fi

# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/set-hostname.html
change_hostname() {
    local name=$1
    if grep -q "^preserve_hostname: false" /etc/cloud/cloud.cfg; then
        sudo sed -i "s/^preserve_hostname: false/preserve_hostname: true/" /etc/cloud/cloud.cfg
    elif ! grep -q "^preserve_hostname: true" /etc/cloud/cloud.cfg; then
        echo "preserve_hostname: true" | sudo tee -a /etc/cloud/cloud.cfg >/dev/null
    fi

    (
        set -x
        sudo hostnamectl set-hostname "${name}"
    )
}

change_hostname "${domain_name}"
