#!/bin/bash
set -eo pipefail

pushd /tmp
wget 'https://www.python.org/ftp/python/3.9.13/python-3.9.13-macos11.pkg'
open 'python-3.9.13-macos11.pkg'
popd >/dev/null

echo "Continue on the installer GUI to complete the installation..."

ln -f /usr/local/bin/python3 /usr/local/bin/python || true
ln -f /usr/local/bin/pip3 /usr/local/bin/pip || true
