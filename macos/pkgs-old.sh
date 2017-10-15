#!/bin/bash
set -e

function install_linux_pkgs {
    sudo apt-get update
    sudo apt-get install -y build-essential python-software-properties python-dev \
        git vim screen ntp tree colordiff \
        wget curl rsync zip gzip bzip2
    sudo apt-get install -y htop hardinfo gufw
    sudo apt-get install -y ttf-mscorefonts-installer
    sudo apt-get install -y chromium-browser
    sudo apt-get install -y exuberant-ctags # vim tagbar plugin
    sudo apt-get install -y ack-grep        # ack.vim plugin (http://beyondgrep.com/install/)
    sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep
    install_fpp
    install_python_pip
    install_python_pkgs

    install_linux_desktop_pkgs
    install_fish_shell
}

function install_fpp {
    mkdir -p ~/bin
    [[ -e ~/.fpp ]] || git clone git@github.com:facebook/PathPicker.git ~/.fpp
    [[ -e ~/bin/fpp ]] || ln -s ~/.fpp/fpp ~/bin/fpp
}

function install_linux_desktop_pkgs {
    local gnome_installed=0; [ $(pgrep gnome | wc -l) -gt 0 ] && gnome_installed=1
    if [ $gnome_installed -eq 1 ]; then
        # gitg - free simple git ui client to see branches and changes/diff before commit
        # gitk - git repository browser
        sudo apt-get install -y vim-gnome xclip gitg gitk diffuse nautilus-open-terminal
    fi
}

function brew_install {
    local pkg=$1
    if brew list -1 | grep -q "^${pkg}\$"; then
        set +e
        brew upgrade $1
        set -e
    else
        (set -x; brew install $@)
    fi
}

function brew_cask_install {
    local pkg=$1
    if brew cask list -1 | grep -q "^${pkg}\$"; then
        set +e
        # upgrade is not availalbe
        #brew cask upgrade $1
        echo "$pkg already installed. Need to manually uninstall and install to upgrade."
        set -e
    else
        (set -x; brew cask install $@)
    fi
}

function install_mac_pkgs {
    (set -x
    brew update
    brew tap homebrew/dupes
    )

    # GNU packages
    brew_install coreutils # GNU ls, readlink etc.
    brew_install findutils # GNU find, locate, updatedb, xargs

    brew_install diffutils # GNU diff, cmp, diff3, sdif
    brew_install wdiff --with-gettext
    brew_install gawk
    brew_install gnu-indent --with-default-names
    brew_install gnu-sed --with-default-names
    brew_install gnu-tar --with-default-names
    brew_install gnu-which --with-default-names
    brew_install gnutls --with-default-names
    brew_install grep --with-default-names
    brew_install screen
    brew_install wget
    brew_install gzip
    brew_install watch

    brew_install openssl
    brew_install openssh

    brew_install git
    # --with-lua for neocomplete.vim
    brew_install vim --override-system-vi --with-lua
    brew_install macvim --override-system-vim --custom-icons --with-lua
    brew_install tree colordiff
    brew_install md5sha1sum
    brew_install ctags # for tagbar vim plugin
    brew_install ack   # for ack.vim plugin

    # https://github.com/facebook/pathpicker/
    brew_install fpp

    # http://www.jenv.be/
    brew_install jenv

    brew_install python
    easy_install -U pip
    install_python_pkgs

    brew_install caskroom/cask/brew-cask

    (set -x; brew cask update)
    brew_cask_install dash
    brew_cask_install alfred
    brew_cask_install flycut
    brew_cask_install dropbox
    brew_cask_install evernote
    brew_cask_install slack
    brew_cask_install virtualbox
    brew_cask_install vagrant
    brew_cask_install java7
    brew_cask_install java # current version is java 8
    brew_cask_install sourcetree
    brew_cask_install github-desktop
    brew_cask_install vlc

    (set -x; brew linkapps)
}

function install_python_pip {
    local prefix
    if [[ $(uname -s) == "Linux" ]]; then
        prefix='sudo -H '
    fi

    cd /tmp
    # https://pip.pypa.io/en/latest/installing/
    $prefix curl -sSLO https://bootstrap.pypa.io/get-pip.py 2>&1 >/dev/null
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
    $prefix pip install --upgrade httpie
}

function install_fish_shell {
    sudo apt-add-repository ppa:fish-shell/release-2
    sudo apt-get update
    sudo apt-get install -y fish

    mkdir -p ~/.config/fish
    chsh -s /usr/bin/fish
}

function main {
    echo "Start installing packages ====="
    case $(uname -s) in
    Linux)
        install_linux_pkgs
        echo "Run fstrim on all SSD brand: Edit /etc/cron.weekly/fstrim and add '--no-model-check' option"
        ;;
    Darwin)
        install_mac_pkgs
        echo "Configure jenv (See: http://www.jenv.be/)"
        ;;
    *)
        echo 'Unknown platform. Fail to insatll.'
        ;;
    esac

    echo "End installing packages ====="
}

# execute main function if no argument provided
${1-main}
