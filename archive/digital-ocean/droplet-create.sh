#!/bin/bash
set -eou pipefail

region=${region:-"sfo2"}
image=${image:-"ubuntu-20-04-x64"}
size=${size:-"s-1vcpu-1gb"}
sshkey=${sshkey:-"28341882"}
userdata=${userdata:-"./cloud-config/ubuntu-20.04-userdata.sh"}
firewall_name=${firewall_name:-"web"}
droplet_name="$@"
droplet_json=$(mktemp /tmp/droplet-XXXX)

echo "Creating droplet ..."
(set -x
    doctl compute droplet create \
        --region ${region} \
        --image ${image} \
        --size ${size} \
        --enable-backups \
        --enable-private-networking \
        --enable-monitoring \
        --ssh-keys ${sshkey} \
        --user-data-file ${userdata} \
        --output json \
        --wait \
        ${droplet_name} | jq -c | tee ${droplet_json}
)

droplet_id=$(cat ${droplet_json} | jq -c '.[].id')
droplet_public_id=$(cat ${droplet_json} | jq -r '.[] | .networks.v4[] | select(.type == "public") | .ip_address')
droplet_private_id=$(cat ${droplet_json} | jq -r '.[] | .networks.v4[] | select(.type == "private") | .ip_address')

echo -e "\n---\n"

firewall_id=$(doctl compute firewall list --output json | jq -r ".[] | select (.name == \"${firewall_name}\") | .id")
if [[ -z ${firewall_id} ]]; then
    echo "Creating and using firewall for ${droplet_id}"
    (set -x
        doctl compute firewall create \
            --name ${firewall_name} \
            --inbound-rules "protocol:tcp,ports:80,address:0.0.0.0/0,address:::/0 protocol:tcp,ports:443,address:0.0.0.0/0,address:::/0 protocol:tcp,ports:4444,address:0.0.0.0/0,address:::/0" \
            --outbound-rules "protocol:icmp,ports:1-65535,address:0.0.0.0/0,address:::/0 protocol:tcp,ports:1-65535,address:0.0.0.0/0,address:::/0 protocol:udp,ports:1-65535,address:0.0.0.0/0,address:::/0" \
            --output json | jq -c
    )
    # Wait until resource is ready
    sleep 10
else
    echo "Using this firewall for ${droplet_id}"
    (set -x
        doctl compute firewall get ${firewall_id} --output json | jq -c
    )
fi
(set -x
    doctl compute firewall add-droplets ${firewall_id} --droplet-ids ${droplet_id}
)

echo -e "\n---\n"

unused_floating_ip=$(doctl compute floating-ip list --output json | jq -r '.[] | select(.droplet == null) | .ip')
if [[ -z ${unused_floating_ip} ]]; then
    echo "Creating floating ip"
    (set -x
        doctl compute floating-ip create --region ${region}
    )
    # Wait until resource is ready
    sleep 10
fi

floating_ip=$(doctl compute floating-ip list --output json | jq -r '.[] | select(.droplet == null) | .ip' | head -n1)

echo "Assign floating ip: ${floating_ip} to ${droplet_id}"
(set -x
doctl compute floating-ip-action assign ${floating_ip} ${droplet_id}
)

echo -e "\n---\n"

echo "
Wait two minutes or more and ssh into the droplet with:
    ssh -p4444 ubuntu@${floating_ip}
"
