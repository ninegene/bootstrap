#!/bin/bash
set -euo pipefail

firewall_name=$1
firewall_id=$(doctl compute firewall list --output json | jq -r ".[] | select (.name == \"${firewall_name}\") | .id")

if [[ -z ${firewall_id} ]]; then
    doctl compute firewall create \
        --name ${firewall_name} \
        --inbound-rules protocol:tcp,ports:80,address:0.0.0.0/0,address:::/0 protocol:tcp,ports:443,address:0.0.0.0/0,address:::/0 protocol:tcp,ports:4444,address:0.0.0.0/0,address:::/0 \
        --outbound-rules protocol:icmp,address:0.0.0.0/0,address:::/0 protocol:tcp,ports:0,address:0.0.0.0/0,address:::/0 protocol:udp,ports:0,address:0.0.0.0/0,address:::/0 \
        --output json
else
    doctl compute firewall get ${firewall_id} \
        --output json
fi
