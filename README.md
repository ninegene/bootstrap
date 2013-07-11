## Installation
### Install Janus Vim distribution
https://github.com/carlhuda/janus

```bash
sudo apt-get install vim rake curl ctags
curl -Lo- https://bit.ly/janus-bootstrap | bash
```
### Setup dotfiles
```bash
cd ~
git clone https://github.com/ninegene/dotfiles.git && cd dotfiles 
git submodule init && git submodule update
sudo pip install --user git+git://github.com/Lokaltog/powerline
```

Clean up dot files in home folder and create soft links to .profile, .aliases etc.:

```bash
./bootstrap.sh 
```

To update, do `git pull` and execute `bootstrap.sh`

## Notes
https://github.com/rupa/z is added as submodule using the following
commands:
```bash
cd dotfiles
git submodule add git://github.com/rupa/z.git
git submodle init
```
