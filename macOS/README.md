# macOS bootstrap

Tested on `macOS 15.7.2`

### Update macOS

```
softwareupdate --install --all
```

## Install Desktop Apps

- [Brave Browser](https://brave.com/)
- [Raycast](https://raycast.com/)
- [Flycut (Clipboard manager)](https://apps.apple.com/us/app/flycut-clipboard-manager/id442160987)
- [Zoom (Meeting)](https://zoom.us/download)
- [Canva (Designer App)](https://apps.apple.com/us/app/canva-ai-photo-video-editor/id897446215)
- [NTFS for Mac - Paragon Software](https://www.paragon-software.com/us/home/ntfs-mac/)
  - [Login & Download](https://uc.paragon-software.com/#/login)
- [NordVPN](https://nordvpn.com/download/mac/)
- [Zed Code Editor](https://zed.dev/)
- [Visual Studio Code](https://code.visualstudio.com/download)
- [iTerm2](https://www.iterm2.com/downloads.html)
  - [Dracula Theme](https://draculatheme.com/iterm)
  - [Cascadia Code - Monospace Font](https://github.com/microsoft/cascadia-code)
- [Docker Desktop](https://www.docker.com/products/docker-desktop)

## System Settings

- iCloud
- Turn off syncing of Photos, iCloud Drive, Messages etc. and only enable syncing for Passwords and Notes
- Spotlight (replaced with [Raycast](https://raycast.com/))
- Uncheck "Show Spotlight in the menu bar"
- Uncheck unneeded Spotlight search categories
- Disable Spotlight keyboard shortcuts
- Disable Spotlight indexing with command: `sudo mdutil -i off`
- Adjust "Lock Screen" Settings
- Turn off Siri

## Install Development Tools

### Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Configure Git

```sh
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Generating a new SSH key

Enter passphrase when prompted.

```sh
ssh-keygen -t ed25519 -C 'my-ssh-key'
```

Also, see [Generating SSH keys](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

#### Use ssh-agent

`ssh-add` is a command that adds SSH private keys to the ssh-agent, which is a background program that manages your SSH keys and remembers your passphrases.

Use `ssh-add` to add your SSH private key to the ssh-agent and store your passphrase in the keychain.

```sh
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

Add the following to `~/.ssh/config` to use the specific SSH key for GitHub.

```ssh
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
```

#### Add SSH public key to GitHub

```sh
pbcopy < ~/.ssh/id_ed25519.pub
```

Add SSH key to [GitHub](https://github.com/settings/keys)

### Run bootstrap scripts to install necessary packages and tools

```sh
# Change to user home directory and clone under ~/bootstrap
cd ~
git clone git@github.com:ninegene/bootstrap.git
cd bootstrap/macOS

./install-brew.sh
./install-aws-cli.sh
./install-cheat-and-tldr.sh
./install-fzf-and-dependencies.sh
./install-gnu-packages.sh
./install-nodejs-24.sh
./install-nvm.sh
./install-postgresql-17.sh
./install-shellcheck-and-shfmt.sh
./install-xcode-command-line-tools.sh
./install-zsh-git-prompt.sh

brew doctor
brew cleanup -s
```

Install [Claude Code CLI](https://claude.com/product/claude-code)
