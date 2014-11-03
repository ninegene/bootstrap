#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: watch.sh <command> <sleep_duration_secounds>"
    exit 0
fi

while :;
  do
  clear;
  echo "$(date)"
  $1;
  sleep $2;
done
