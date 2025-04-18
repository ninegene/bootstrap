#!/bin/bash
set -eo pipefail

# Based on: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

type -p unzip >/dev/null || (sudo apt update && sudo apt-get install unzip -y)

cd /tmp
rm -rf /tmp/aws /tmp/awscliv2.zip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip

if type -p aws >/dev/null; then
    sudo ./aws/install --update
else
    sudo ./aws/install
fi

aws --version
