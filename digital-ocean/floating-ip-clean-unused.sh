#!/bin/bash
set -euo pipefail

unused_floating_ip=$(doctl compute floating-ip list --output json | jq -r '.[] | select(.droplet == null) | .ip')

if [[ -n ${unused_floating_ip} ]]; then
    doctl compute floating-ip list --output json | jq -r '.[] | select(.droplet == null) | .ip' \
        | tr '\n' '\0' \
        | xargs -0 -I{x} doctl compute floating-ip delete --force {x}
    echo "Deleted unused floating ip: ${unused_floating_ip}"
else
    echo "Not found unused floating ip!"
fi

