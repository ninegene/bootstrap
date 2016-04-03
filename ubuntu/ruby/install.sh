#!/bin/bash
set -e

CURDIR=$(dirname "$(readlink -f "$0")")
version=${1-2.2}

if [[ $version == '2.2' ]]; then
    gempriority=191
    rubypriority=61
elif [[ $version == '2.1' ]]; then
    gempriority=181
    rubypriority=51
elif [[ $version == '2.0' ]]; then
    gempriority=171
    rubypriority=41
fi

# based on:
# https://github.com/phusion/passenger-docker/blob/master/image/ruby2.2.sh
# https://github.com/phusion/passenger-docker/blob/master/image/ruby-finalize.sh

(set -x; sudo add-apt-repository ppa:brightbox/ruby-ng)
# sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com F5DA5F09C3173AA6
# echo deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/brightbox.list

sudo apt-get update
(set -x;
sudo apt-get install -y --no-install-recommends ruby${version} ruby${version}-dev
sudo update-alternatives --install /usr/bin/gem gem /usr/bin/gem${version} ${gempriority}
sudo update-alternatives \
    --install /usr/bin/ruby ruby /usr/bin/ruby${version} ${rubypriority} \
    --slave /usr/bin/erb erb /usr/bin/erb${version} \
    --slave /usr/bin/testrb testrb /usr/bin/testrb${version} \
    --slave /usr/bin/rake rake /usr/bin/rake${version} \
    --slave /usr/bin/irb irb /usr/bin/irb${version} \
    --slave /usr/bin/rdoc rdoc /usr/bin/rdoc${version} \
    --slave /usr/bin/ri ri /usr/bin/ri${version} \
    --slave /usr/share/man/man1/ruby.1.gz ruby.1.gz /usr/share/man/man1/ruby${version}.*.gz \
    --slave /usr/share/man/man1/erb.1.gz erb.1.gz /usr/share/man/man1/erb${version}.*.gz \
    --slave /usr/share/man/man1/irb.1.gz irb.1.gz /usr/share/man/man1/irb${version}.*.gz \
    --slave /usr/share/man/man1/rake.1.gz rake.1.gz /usr/share/man/man1/rake${version}.*.gz \
    --slave /usr/share/man/man1/ri.1.gz ri.1.gz /usr/share/man/man1/ri${version}.*.gz
sudo gem${version} install rake bundler --no-rdoc --no-ri
)

## Fix shebang lines in rake and bundler so that they're run with the currently
## configured default Ruby instead of the Ruby they're installed with.
sudo sed -E -i 's|/usr/bin/env j?ruby.*$|/usr/bin/env ruby|; s|/usr/bin/j?ruby.*$|/usr/bin/env ruby|' \
    /usr/local/bin/rake /usr/local/bin/bundle /usr/local/bin/bundler

sudo cp $CURDIR/ruby-switch /usr/local/bin/ruby-switch

(set -x; ruby-switch --list)

echo "
Run the following to switch to verison $version:
    ruby-switch --set ruby${version}
"
