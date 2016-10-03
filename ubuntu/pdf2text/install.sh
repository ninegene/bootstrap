#!/bin/bash
set -e

echo "Running apt-get update ..."
sudo apt-get update >/dev/null

sudo apt-get install python-pdfminer
sudo apt-get install poppler-utils

apt-cache show poppler-utils

pdf2txt -h

