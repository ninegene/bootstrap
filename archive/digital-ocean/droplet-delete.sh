#!/bin/bash
set -euo pipefail

droplet_name=$1
droplet_ids=$(doctl compute droplet list --output json | jq  ".[] | select (.name | contains(\"${droplet_name}\")) | .id")

if [[ -n ${droplet_ids} ]]; then
    for droplet_id in ${droplet_ids}; do
        doctl compute droplet get ${droplet_id}
        doctl compute droplet delete ${droplet_id}
    done
    # echo "Waiting to delete unused floating ip addresses ..."
    # sleep 30
    # ./floating-ip-clean-unused.sh
    echo "Make sure to delete unused floating ip addresses!"
    doctl compute floating-ip list
else
   echo "Not droplets found to be deleted!"
fi
