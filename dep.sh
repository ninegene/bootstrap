#!/bin/bash

function linux {
    sudo apt-get install git
    sudo apt-get install gitg
    sudo apt-get install tree colordiff # used in shell aliases
    sudo apt-get install exuberant-ctags # for vim tagbar plugin
    # ack.vim vim plugin
    # http://beyondgrep.com/install/
    sudo apt-get install ack-grep
    sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep
}

function mac {
    sudo port install git-core +bash_completion +credential_osxkeychain +doc +pcre +python27
    sudo port install tree colordiff # for aliases
    sudo port install ctags # for tagbar vim plugin
    sudo port install p5-app-ack # for ack.vim plugin
    echo 'Install SourceTree git ui client tool from the website'
    open http://www.sourcetreeapp.com/
}

case $(uname -s) in
Linux)
    linux
    ;;
Darwin)
    mac
    ;;
*)
    echo 'Unknown platform. Fail to insatll.'
    ;;
esac
