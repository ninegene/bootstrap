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

### Remove submodule
To remove a submodule you need to:

* Delete the relevant section from the .gitmodules file.
* Stage the .gitmodules changes git add .gitmodules
* Delete the relevant section from .git/config.
* Run git rm --cached path_to_submodule (no trailing slash).
* Run rm -rf .git/modules/path_to_submodule
* Commit git commit -m "Removed submodule <name>"
* Delete the now untracked submodule files
  rm -rf path_to_submodule

Taken from http://stackoverflow.com/questions/1260748/how-do-i-remove-a-git-submodule#1260982
