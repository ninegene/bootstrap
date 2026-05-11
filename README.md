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
- In System Settings, go to Spotlight, click Search Privacy in the lower right, then add the disk you want to exclude from Spotlight indexing
- Adjust "Lock Screen" Settings
- Turn off Siri

### mdutil
```
 $ mdutil
Usage: mdutil -pEsa -i (on|off) -d volume ...
       mdutil -t {volume-path | deviceid} fileid
	Utility to manage Spotlight indexes.
	-i (on|off)    Turn indexing on or off.
	-d             Disable Spotlight activity for volume (re-enable using -i on).
	-E             Erase and rebuild index.
	-s             Print indexing status.
	-a             Apply command to all stores on all volumes.
	-t             Resolve files from file id with an optional volume path or device id.
	-p             Publish metadata.
	-V vol         Apply command to all stores on the specified volume.
	-v             Display verbose information.
	-r plugins     Ask the server to reimport files for UTIs claimed by the listed plugin.
	-L volume-path List the directory contents of the Spotlight index on the specified volume.
	-P volume-path Dump the VolumeConfiguration.plist for the specified volume.
	-X volume-path Remove the Spotlight index directory on the specified volume.  Does not disable indexing.
	               Spotlight will reevaluate volume when it is unmounted and remounted, the
	               machine is rebooted, or an explicit index command such as 'mdutil -i' or 'mdutil -E' is
	               run for the volume.
NOTE: Run as owner for network homes, otherwise run as root.
```

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
./disable-spotlight-indexing.sh
./install-aws-cli.sh
./install-fzf-and-dependencies.sh
./install-github-cli.sh
./install-gnu-packages.sh
./install-go.sh
./install-ruby.sh
./install-nodejs-24.sh
./install-uv.sh
./install-opencode-cli.sh
./install-claude-code.sh
./install-ai-instructions.sh
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

The shared AI instruction template lives in [`macOS/ai-instructions.md`](macOS/ai-instructions.md). The installer symlinks it to the supported global locations for Copilot (`~/.config/github-copilot/global-copilot-instructions.md` and `~/.copilot/instructions/global.instructions.md`), OpenCode (`~/.opencode/AGENTS.md`), Codex (`~/.codex/AGENTS.md`), and Claude (`~/.claude/CLAUDE.md`).

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
