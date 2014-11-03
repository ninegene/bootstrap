#!/bin/bash

set -e

cur_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#gnome_installed=0; [ $(pgrep gnome | wc -l) -gt 0 ] && gnome_installed=1
gnome_installed=0; [ $(ps -ef | grep gnome | grep -v grep | wc -l) -gt 0 ] && gnome_installed=1

function install_linux_pkgs {
    sudo apt-get update
    sudo apt-get install -y python-software-properties python-dev
    sudo apt-get install -y git
    sudo apt-get install -y vim
    sudo apt-get install -y screen
    sudo apt-get install -y wget curl tree colordiff
    sudo apt-get install -y htop atop rsync zip unzip gzip bzip2
    if [ $gnome_installed -eq 1 ]; then
        sudo apt-get install -y vim-gtk vim-gnome xclip
        sudo apt-get install -y nautilus-open-terminal
        sudo apt-get install -y gitk # git repository browser
        sudo apt-get install -y gitg # free simple git ui client to see branches and changes/diff before commit
    fi
    sudo apt-get install -y exuberant-ctags # for vim tagbar plugin
    # ack.vim vim plugin
    # http://beyondgrep.com/install/
    sudo apt-get install -y ack-grep
    sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

    install_python_pip
}

function install_mac_pkgs {
    # sudo port -v selfupdate
    # sudo port install vim +cscope +python +ruby +perl +tcl
    # sudo port install macvim +cscope +python +ruby +perl +tcl
    # sudo port install git-core +bash_completion +credential_osxkeychain +doc +pcre +python27
    # sudo port install tree colordiff # for aliases
    # sudo port install ctags # for tagbar vim plugin
    # sudo port install p5-app-ack # for ack.vim plugin

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
    #brew install gzip
    #brew install rsync
    brew install watch

    brew install openssl
    brew install openssh
    brew install python
    brew linkapps

    brew install git
    brew install vim --override-system-vi
    brew install macvim --override-system-vim --custom-system-icons
    brew install tree colordiff # used in aliases
    brew install md5sha1sum     # used in aliases
    brew install ctags # for tagbar vim plugin
    brew install ack   # for ack.vim plugin
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

function show_more_info {
    case $(uname -s) in
    Linux)
        if [ $gnome_installed -eq 1 ]; then
           echo ''
        fi
        ;;
    Darwin)
        echo Install SourceTree git ui client from http://www.sourcetreeapp.com
        #open http://www.sourcetreeapp.com/
        ;;
    *)
        ;;
    esac
 }

function main {
    echo "Start installing dependencies ====="
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
    show_more_info
    echo "End installing dependencies ====="
}

main
