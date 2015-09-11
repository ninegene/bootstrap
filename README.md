# dotfiles
My dotfiles created for Ubuntu and Mac OS X.

```bash
$ git clone https://github.com/ninegene/dotfiles.git ~/.files
```

## Help

```bash
$ ~/.files/setup.sh --help

USAGE
    setup.sh {pkgs|gitconfig|bash|fish|vim|all}

DESCRIPTION
    pkgs        Install base packages
    gitconfig   Setup git config and git aliases
    bash        Setup dotfiles (.profile, .bashrc etc.) for BASH
    fish        Setup fish shell config
    vim         Setup VIM plugins
    all         Execute all above options (Default)
```

## Installation

#### Setup all options
```bash
$ ~/.files/setup.sh
```

#### Setup Vim only
```
$ ~/.files/setup.sh vim
```

#### Setup Git config, Vim and Fish
```
$ ~/.files/setup.sh gitconfig vim fish
```

## Update

```bash
$ cd ~/.files
$ git pull
$ ./setup.sh
```
