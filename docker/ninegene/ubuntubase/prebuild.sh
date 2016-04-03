#!/bin/bash

basedir=$(dirname "$(readlink -f "$0")")

if [[ ! -f $basedir/authorized_keys && -f ~/.ssh/id_rsa.pub ]]; then
    cat ~/.ssh/id_rsa.pub >> $basedir/authorized_keys
fi
