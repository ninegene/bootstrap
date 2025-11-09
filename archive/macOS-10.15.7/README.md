
## macOS bootstrap
Tested on `macOS Catalina 10.15.7`

- [System Preferences](https://sourabhbajaj.com/mac-setup/SystemPreferences/)

```
$ cd
$ git clone git@github.com:ninegene/bootstrap.git
$ cd bootstrap/macOS
$ ./install-xcode-command-line-tools.sh
$ ./install-homebrew.sh
$ ./install-gnu-packages.sh

$ brew cleanup -s
```

### Install Desktop Apps
- [LuLu Firewall](https://objective-see.com/products/lulu.html)
- [Visual Studio Code](https://code.visualstudio.com/download)
- [Flycut (Clipboard manager)](https://apps.apple.com/us/app/flycut-clipboard-manager/id442160987)
- [iTerm2](https://www.iterm2.com/downloads.html)
  - [Dracula Theme](https://draculatheme.com/iterm)
  - [Cascadia Code - Monospace Font](https://github.com/microsoft/cascadia-code)
- [NTFS for Mac - Paragon Software](https://www.paragon-software.com/us/home/ntfs-mac/)
  - [Login & Download](https://uc.paragon-software.com/#/login)


## macOS SSH key Setup
### Generating a new SSH key

Based on: https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

```
$ ssh-keygen -t ed25519 -C 'name@email.com'
```

### Use ssh-agent
```
$ vi ~/.ssh/config
```

Add the following to `~/.ssh/config`
```
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
```

```
$ ssh-add -K ~/.ssh/id_ed25519
```

### Add SSH public key to GitHub
```
$ pbcopy < ~/.ssh/id_ed25519.pub
```
Add SSH key to [GitHub](https://github.com/settings/keys)


