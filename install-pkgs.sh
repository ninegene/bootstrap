#!/bin/bash
set -e

function install_linux_pkgs {
    sudo apt-get update
    sudo apt-get install -y python-software-properties python-dev
    sudo apt-get install -y git
    sudo apt-get install -y vim
    sudo apt-get install -y screen
    sudo apt-get install -y wget curl tree colordiff
    sudo apt-get install -y htop atop rsync zip unzip gzip bzip2

    local gnome_installed=0; [ $(pgrep gnome | wc -l) -gt 0 ] && gnome_installed=1
    if [ $gnome_installed -eq 1 ]; then
        sudo apt-get install -y vim-gtk vim-gnome xclip
        sudo apt-get install -y nautilus-open-terminal
        sudo apt-get install -y gitg # free simple git ui client to see branches and changes/diff before commit
        sudo apt-get install -y gitk # git repository browser
    fi
    sudo apt-get install -y exuberant-ctags # for vim tagbar plugin
    # ack.vim vim plugin
    # http://beyondgrep.com/install/
    sudo apt-get install -y ack-grep
    sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

    install_python_pip
}

function install_mac_pkgs {
    brew update
    brew tap homebrew/dupes

    # GNU packages
    brew install coreutils
    brew install findutils --default-names # GNU find, locate, updatedb, xargs
    brew install diffutils # GNU diff, cmp, diff3, sdif
    brew install wdiff --with-gettext
    brew install gawk
    brew install gnu-indent --default-names
    brew install gnu-sed --default-names
    brew install gnu-tar --default-names
    brew install gnu-which --default-names
    brew install gnutls --default-names
    brew install grep --default-names
    brew install screen
    brew install wget
    brew install gzip
    brew install watch

    brew install openssl
    brew install openssh
    brew install python

    brew install git
    brew install vim --override-system-vi
    brew install macvim --override-system-vim --custom-system-icons
    brew install tree colordiff
    brew install md5sha1sum
    brew install ctags # for tagbar vim plugin
    brew install ack   # for ack.vim plugin

    brew linkapps
    # Needs to run the following to work around MacVim not available in spot light or alfred
    # mv /usr/local/Cellar/macvim/7.4-73_1/MacVim.app /Applications/
    # ln -s /Applications/MacVim.app /usr/local/Cellar/macvim/7.4-73_1/
}

function install_python_pip {
    cd /tmp
    # http://pip.readthedocs.org/en/latest/installing.html
    sudo curl -O https://bootstrap.pypa.io/get-pip.py 2>&1 >/dev/null
    sudo python get-pip.py 2>&1 >/dev/null
    sudo rm get-pip.py
    cd -
    pip --version
}

function install_python_pkgs {
    sudo pip install --upgrade flake8 # wrapper for - pep8 pyflakes mccabe
    sudo pip install --upgrade pylint
    sudo pip install --upgrade jedi   # jedi vim plugin
    sudo pip install --upgrade virtualenv
    sudo pip install --upgrade fabric
}

function main {
    echo "Start installing packages ====="
    case $(uname -s) in
    Linux)
        install_linux_pkgs
        ;;
    Darwin)
        install_mac_pkgs
        ;;
    *)
        echo 'Unknown platform. Fail to insatll.'
        ;;
    esac

    install_python_pkgs
    echo "End installing packages ====="
}

main
