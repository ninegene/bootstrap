# bootstrap

Bootstrap scripts for development environments on MacBooks and Cloud servers.

## macOS

Tested on `macOS 15.7.2`

### Update macOS

```sh
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
  - [Dracula Theme](https://github.com/ninegene/iterm-dracula-dark-theme)
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

./install-homebrew.sh
./install-xcode-command-line-tools.sh
./install-aws-cli.sh
./install-fzf-and-dependencies.sh
./install-github-cli.sh
./install-gnu-packages.sh
./install-go.sh
./install-nodejs-24.sh
./install-openai-codex-cli.sh
./install-claude-code.sh
./install-nvm.sh
./install-postgresql-18.sh
./install-shellcheck-and-shfmt.sh
./install-zsh-git-prompt.sh
./configure-iterm.sh
./configure-git.sh
./configure-vim.sh
./configure-zsh.sh

brew doctor
brew cleanup -s
```

## Git hooks (Lefthook)

This repo uses [Lefthook](https://github.com/evilmartians/lefthook) to run checks on staged files before each commit.

### Install

Lefthook is included as a step in `bootstrap.sh`. To install it standalone:

```bash
brew install lefthook
lefthook install
```

### Hooks

Defined in [`lefthook.yml`](lefthook.yml), these run in parallel on `git commit`:

| Hook           | Files  | What it checks                                      |
| -------------- | ------ | --------------------------------------------------- |
| `shellcheck`   | `*.sh` | Shell script issues (severity: warning+)            |
| `shfmt`        | `*.sh` | Formatting — 4-space indent, consistent indentation |
| `markdownlint` | `*.md` | Markdown style and structure                        |

### Common commands

```bash
# Run all pre-commit hooks manually against staged files
lefthook run pre-commit

# Run a single hook by name
lefthook run pre-commit --commands shellcheck

# Skip hooks for a one-off commit
LEFTHOOK=0 git commit -m "message"

# Re-install hooks after pulling changes to lefthook.yml
lefthook install
```
