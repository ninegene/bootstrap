# dotfiles
My configs for shell, vim, git etc. created for Ubuntu/Linux Mint and Mac OS X.

```bash
$ git clone https://github.com/ninegene/dotfiles.git ~/dotfiles
```

## Help

```bash
$ ~/dotfiles/setup.sh --help

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
$ ~/dotfiles/setup.sh
```

#### Setup Vim only
```
$ ~/dotfiles/setup.sh vim
```

#### Setup Git config, Vim and Fish
```
$ ~/dotfiles/setup.sh gitconfig vim fish
```

## Update

```bash
$ cd ~/dotfiles
$ git pull
$ ./setup.sh
```
