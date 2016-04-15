#!/bin/bash
set -e

version=${1-2.1.1}

set -u

CURDIR=$(dirname "$(readlink -f "$0")")
ZIP_FILE=$(${CURDIR}/download.sh $version | tail -1)

# Assume dir inside zip file has the same name as zip file without extension
GROOVY_DIRNAME=$(unzip -l ${ZIP_FILE} | head -4 | tail -1 | awk '{print $4}' | sed -e 's#/$##')

# To directory where downloaded tar.gz file located
cd $(dirname ${ZIP_FILE})

if [ -d /usr/local/${GROOVY_DIRNAME} ]; then
    echo "/usr/local/${GROOVY_DIRNAME} exists!"
    echo "Existing..."
    exit 1
fi

if [ -L /usr/local/groovy ]; then
   sudo rm /usr/local/groovy
fi

if [ -d /usr/local/groovy ]; then
  sudo mv /usr/local/groovy /usr/local/groovy_old
fi

(set -x
unzip -q ${ZIP_FILE}
sudo mv ${GROOVY_DIRNAME}/ /usr/local/
sudo ln -s /usr/local/${GROOVY_DIRNAME} /usr/local/groovy
sudo chown -R $(whoami):$(whoami) /usr/local/groovy
)

/usr/local/groovy/bin/groovy --version
echo "Finish installation to /usr/local/${GROOVY_DIRNAME}"
