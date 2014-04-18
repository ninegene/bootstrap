#!/bin/bash

set -e

#gnome_installed=0; [ $(pgrep gnome | wc -l) -gt 0 ] && gnome_installed=1
gnome_installed=0; [ $(ps -ef | grep gnome | grep -v grep | wc -l) -gt 0 ] && gnome_installed=1

function install_linux_pkgs {
    sudo apt-get update
    sudo apt-get -y install vim curl
    if [ $gnome_installed -eq 1 ]; then
        sudo apt-get install -y vim-gtk vim-gnome
        sudo apt-get install -y gitk # git repository browser
        sudo apt-get install -y gitg # free simple git ui client to see branches and changes/diff before commit
    fi
    sudo apt-get install -y tree colordiff # used in shell aliases
    sudo apt-get install -y exuberant-ctags # for vim tagbar plugin
    # ack.vim vim plugin
    # http://beyondgrep.com/install/
    sudo apt-get install -y ack-grep
    sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep
}

function install_mac_pkgs {
    sudo port -v selfupdate
    sudo port install vim +cscope +python +ruby +perl +tcl
    sudo port install macvim +cscope +python +ruby +perl +tcl
    sudo port install git-core +bash_completion +credential_osxkeychain +doc +pcre +python27
    sudo port install tree colordiff # for aliases
    sudo port install ctags # for tagbar vim plugin
    sudo port install p5-app-ack # for ack.vim plugin
}

function install_python_pip {
    # http://stackoverflow.com/questions/549737/how-can-i-redirect-stderr-to-stdout-but-ignore-the-original-stdout
    cd /tmp
    # sudo curl -O https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py 2>&1 >/dev/null
    # sudo python ez_setup.py 2>&1 >/dev/null
    # sudo rm ez_setup.py setuptools-*.tar.gz

    # http://pip.readthedocs.org/en/latest/installing.html
    # If setuptools (or distribute) is not already installed, get-pip.py will install setuptools for you.
    sudo curl -O https://raw.github.com/pypa/pip/master/contrib/get-pip.py 2>&1 >/dev/null
    sudo python get-pip.py 2>&1 >/dev/null
    sudo rm get-pip.py
    cd -
    pip --version
}

function install_vim_python_pkgs {
    sudo pip install --upgrade virtualenv
    sudo pip install --upgrade flake8 # wrapper for - pep8 pyflakes mccabe
    sudo pip install --upgrade pylint
    sudo pip install --upgrade jedi
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

    install_python_pip
    install_vim_python_pkgs
    show_more_info
    echo "End installing dependencies ====="
}

main
