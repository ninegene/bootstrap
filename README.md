# dotfiles
My dotfiles created for Ubuntu and Mac OS X.

```bash
$ git clone https://github.com/ninegene/dotfiles.git ~/.files
```

## Help

```bash
$ ~/.files/setup.sh --help

USAGE
    setup.sh {pkgs|git|bash|fish|vim|scripts|all}

DESCRIPTION
    pkgs        Install base packages
    git         Setup git config and git aliases
    bash        Setup dotfiles for BASH
    fish        Setup fish shell config
    vim         Setup VIM plugins
    scripts     Symlink scripts to ~/bin directory
    all         Execute all above options (Default)
```

## Installation

```bash
$ ~/.files/setup.sh

VIM only
$ ~/.files/setup.sh vim
```

## Update

```bash
$ cd ~/.files
$ git pull
$ ./setup.sh
```
