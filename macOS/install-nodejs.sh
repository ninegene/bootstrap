#!/bin/bash
set -eo pipefail


major_version=16
version=16.14.0

set -x
cd /tmp
curl -L https://nodejs.org/dist/latest-v${major_version}.x/node-v${version}.pkg -o node-v${version}.pkg

open node-v${version}.pkg
