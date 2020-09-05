#!/bin/bash
set -ex

brew uninstall --force node
brew install node@8
ln -sf /usr/local/opt/node@8/bin/node /usr/local/bin/node
ln -sf /usr/local/opt/node@8/libexec/bin/npm /usr/local/bin/npm
ln -sf /usr/local/opt/node@8/libexec/bin/npx /usr/local/bin/npx
