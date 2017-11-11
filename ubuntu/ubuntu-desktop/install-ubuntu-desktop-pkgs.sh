#!/bin/bash
set -e

sudo apt-get update
sudo apt-get install -y gufw
sudo apt-get install -y ttf-mscorefonts-installer
sudo apt-get install -y xclip gitg gitk diffuse nautilus-open-terminal

sudo add-apt-repository ppa:synapse-core/ppa
sudo apt-get update
sudo apt-get install synapse
echo "
Open synapse and change the preferences to launch on start up
and change activate shortcut if necessary.
"
sleep 5

# See: http://askubuntu.com/questions/79280/how-to-install-chrome-browser-properly-via-command-line
sudo apt-get install libxss1 libappindicator1 libindicator7
cd /tmp/
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
echo "
If error messages pop up after running the command sudo dpkg -i google-chrome*.deb then run the command

    sudo apt-get install -f
"
