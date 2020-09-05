#!/bin/bash
set -e

install_base_pkgs() {
    (set -x
    sudo apt-get update
    sudo apt-get install -y git vim python-pip
    sudo apt-get install -y screen htop ntp tree colordiff wget curl rsync zip gzip bzip2
    sudo apt-get install -y exuberant-ctags # vim tagbar plugin
    )
}

install_fpp() {
    if [[ -d ~/.fpp ]]; then
        (set -x
        cd ~/.fpp
        git pull
        )
    else
        (set -x
        git clone git@github.com:facebook/PathPicker.git ~/.fpp
        sudo ln -sf ~/.fpp/fpp /usr/local/bin/fpp
        )
    fi
}

install_linux_desktop_pkgs() {
    #local gnome_installed=0; [ $(pgrep gnome | wc -l) -gt 0 ] && gnome_installed=1
    #if [ $gnome_installed -eq 1 ]; then
    if [[ $DESKTOP_SESSION ]]; then
        # gitg - Simple git ui client to see branches and changes/diff before commit
        # gitk - Git repository browser
        (set -x
        sudo apt-get install -y gitg gitk
        sudo apt-get install -y diffuse nautilus-open-terminal
        sudo apt-get install -y xclip
        sudo apt-get install -y gufw
	sudo apt-get install -y ttf-mscorefonts-installer
        )
    fi
}

install_python_pkgs() {
    (set -x
    sudo pip install --upgrade pip
    sudo pip install --upgrade flake8 # wrapper for - pep8 pyflakes mccabe
    sudo pip install --upgrade pylint
    sudo pip install --upgrade jedi   # jedi vim plugin
    sudo pip install --upgrade virtualenv
    sudo pip install --upgrade fabric
    sudo pip install --upgrade httpie
    )
}

install_fish_shell() {
    (set -x
    sudo apt-add-repository ppa:fish-shell/release-2
    sudo apt-get update
    sudo apt-get install -y fish

    mkdir -p ~/.config/fish
    chsh -s /usr/bin/fish
    )
}

install_nvm() {
    (set -x
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh > /tmp/nvm_install.sh
    chmod a+x /tmp/nvm_install.sh
    /tmp/nvm_install.sh
    rm /tmp/nvm_install.sh

    # Install under bash
    ${HOME}/.nvm/install.sh

    . ${HOME}/.nvm/nvm.sh
    nvm install node
    nvm alias default node
    )
}

install_rbenv() {
    (set -x
    sudo apt-get update
    sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev

    git clone git://github.com/rbenv/rbenv.git $HOME/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $HOME/.bashrc
    echo 'eval "$(rbenv init -)"' >> $HOME/.bashrc
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"

    git clone git://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> $HOME/.bashrc
    export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

    git clone https://github.com/rbenv/rbenv-gem-rehash.git $HOME/.rbenv/plugins/rbenv-gem-rehash

    rbenv install 2.3.0
    rbenv global 2.3.0
    ruby --version
    )
}

install_ant() {
    cd /tmp

    curl -O -L http://mirror.sdunix.com/apache/ant/binaries/apache-ant-1.9.5-bin.tar.gz
    tar xzvf apache-ant-1.9.5-bin.tar.gz
    sudo mv apache-ant-1.9.5 /usr/local/

    if [ -L /usr/local/ant ]; then
        echo Removing symlink /usr/local/ant
        sudo rm /usr/local/ant
    fi
    sudo ln -s /usr/local/apache-ant-1.9.5 /usr/local/ant


    if [ -L /usr/bin/ant ]; then
        echo Removing symlink /usr/bin/ant
        sudo rm /usr/bin/ant
    fi
    sudo ln -s /usr/local/ant/bin/ant /usr/bin/ant
}

main() {
    install_base_pkgs
    install_fpp
    install_python_pkgs
    install_fish_shell
    install_linux_desktop_pkgs
}

# execute main function if no argument provided
${1-main}
