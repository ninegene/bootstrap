#!/bin/bash

name=$1

doctl compute firewall list --output json | jq -r ".[] | select (.name == \"${name}\") | .id"
