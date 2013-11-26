#!/bin/bash

sudo apt-get install git

# shell aliases
sudo apt-get install tree colordiff

# tagbar vim plugin
sudo apt-get install exuberant-ctags

# ack.vim vim plugin
# http://beyondgrep.com/install/
sudo apt-get install ack-grep
sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep
