#!/bin/bash
set -e

function install_linux_pkgs {
    sudo apt-get update
    sudo apt-get install -y build-essential python-software-properties python-dev \
        git vim screen ntp wget curl tree colordiff \
        htop atop rsync zip gzip bzip2
    sudo apt-get install -y exuberant-ctags # vim tagbar plugin
    sudo apt-get install -y ack-grep        # ack.vim plugin (http://beyondgrep.com/install/)
    sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep
    install_fpp
    install_python_pip
    install_python_pkgs

    install_linux_desktop_pkgs
}

function install_fpp {
    mkdir -p ~/bin
    [[ -e ~/bin/PathPicker ]] || git clone git@github.com:facebook/PathPicker.git ~/bin/PathPicker
    [[ -e ~/bin/fpp ]] || ln -s ~/bin/PathPicker/fpp ~/bin/fpp
}

function install_linux_desktop_pkgs {
    local gnome_installed=0; [ $(pgrep gnome | wc -l) -gt 0 ] && gnome_installed=1
    if [ $gnome_installed -eq 1 ]; then
        # gitg - free simple git ui client to see branches and changes/diff before commit
        # gitk - git repository browser
        sudo apt-get install -y vim-gtk vim-gnome xclip \
            gitg gitk diffuse nautilus-open-terminal
    fi
}

function install_mac_pkgs {
    brew update
    brew tap homebrew/dupes

    # GNU packages
    brew install coreutils
    brew install findutils --with-default-names # GNU find, locate, updatedb, xargs
    # We don't want to use GNU locate, so rename it
    sudo mv /usr/local/bin/locate /usr/local/bin/glocate

    brew install diffutils # GNU diff, cmp, diff3, sdif
    brew install wdiff --with-gettext
    brew install gawk
    brew install gnu-indent --with-default-names
    brew install gnu-sed --with-default-names
    brew install gnu-tar --with-default-names
    brew install gnu-which --with-default-names
    brew install gnutls --with-default-names
    brew install grep --with-default-names
    brew install screen
    brew install wget
    brew install gzip
    brew install watch

    brew install openssl
    brew install openssh
    brew install python
    easy_install -U pip
    install_python_pkgs

    brew install git
    # --with-lua for neocomplete.vim
    brew install vim --override-system-vi --with-lua
    brew install macvim --override-system-vim --custom-icons --with-lua
    brew install tree colordiff
    brew install md5sha1sum
    brew install ctags # for tagbar vim plugin
    brew install ack   # for ack.vim plugin

    brew install fpp

    brew linkapps
    echo "
    Needs to run the following to work around MacVim not available in spot light or alfred
      $ mv /usr/local/Cellar/macvim/7.4-73_1/MacVim.app /Applications/
      $ ln -s /Applications/MacVim.app /usr/local/Cellar/macvim/7.4-73_1/
    "
}

function install_python_pip {
    local prefix
    if [[ $(uname -s) == "Linux" ]]; then
        prefix='sudo '
    fi

    cd /tmp
    # http://pip.readthedocs.org/en/latest/installing.html
    $prefix curl -O https://bootstrap.pypa.io/get-pip.py 2>&1 >/dev/null
    $prefix python get-pip.py 2>&1 >/dev/null
    $prefix rm get-pip.py
    cd -
    pip --version
}

function install_python_pkgs {
    local prefix
    if [[ $(uname -s) == "Linux" ]]; then
        prefix='sudo '
    fi
    $prefix pip install --upgrade flake8 # wrapper for - pep8 pyflakes mccabe
    $prefix pip install --upgrade pylint
    $prefix pip install --upgrade jedi   # jedi vim plugin
    $prefix pip install --upgrade virtualenv
    $prefix pip install --upgrade fabric
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

    echo "End installing packages ====="
}

# execute main function if no argument provided
${1-main}
