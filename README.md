## Installation

### Clone the repository and init/update submodules
```bash
cd ~
git clone https://github.com/ninegene/dotfiles.git 
cd ~/dotfiles && git submodule init && git submodule update
```

Clean up dot files in home folder and create soft links to .profile, .aliases etc.

For Bash:
```bash
~/bash/bootstrap.sh 
```

To update, do `git pull` and execute `bootstrap.sh` again

## Notes

### Git

#### Add submodule
```bash
cd dotfiles
git submodule add git://github.com/rupa/z.git
git submodle init
```
```bash
cd dotfiles
git submodule add git://github.com/tpope/vim-sensible.git .vim/bundle/vim-sensible
git submodule add git://github.com/tpope/vim-scriptease.git .vim/bundle/vim-scriptease
git submodule add git://github.com/tpope/vim-eunuch.git .vim/bundle/vim-eunuch
git submodule add git://github.com/tpope/vim-fugitive.git .vim/bundle/vim-fugitive
git submodule add git://github.com/tpope/vim-surround.git .vim/bundle/vim-surround
git submodule add git://github.com/kien/ctrlp.vim.git .vim/bundle/ctrlp.vim
git submodule init
```

#### Remove submodule
To remove a submodule you need to:

* Delete the relevant section from the .gitmodules file.
* Stage the .gitmodules changes git add .gitmodules
* Delete the relevant section from .git/config.
* Run git rm --cached path_to_submodule (no trailing slash).
* Run rm -rf .git/modules/path_to_submodule
* Commit git commit -m "Removed submodule <name>"
* Delete the now untracked submodule files
  rm -rf path_to_submodule

Source: http://stackoverflow.com/questions/1260748/how-do-i-remove-a-git-submodule#1260982

### Vim

* https://github.com/tpope/vim-pathogen/
