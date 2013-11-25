## Installation

```bash
cd ~
git clone https://github.com/ninegene/dotfiles.git
cd ~/dotfiles && git submodule init && git submodule update
```

`bootstrap.sh` backup dot files in home folder and create soft links to .profile, .aliases etc.

For Bash shell:
```bash
~/dotfile/bash/bootstrap.sh
```

To update, do `git pull` and execute `bootstrap.sh` again

## VIM

### Mappings
* `Ctrl-Shift-Up` and `Ctrl-Shift-Down` to move current line/selected block of lines up and down
* `Ctrl-C` to copy in virtual mode
* `p` in visual mode replace the selected text with the yank register
* `,d` (or `,dd` or `,dj` or `20,dd`) to delete without adding it to the yanked stack
* Yank/paste to the OS clipboard with `,y`, `,P` and `,p`
* `,r` to show registers for text cut and yanked
* `*` and `#` to search current selection in virtual mode
* `gv` to vimgrep after the selected text in virtual mode
* `<F2>` Toggle paste mode (which allow to paste without formatting/indenting) in normol and insert mode
* `\w`   Toggle wrap
* `\n`   Toggle show line number
* `\tw`  Toggle textwidth between 0 and 100 - used to break long line that is being inserted. Also toggle right
  column in Vim 7.3
* `\t`   :set expandtab tabstop=4 shiftwidth=4 softtabstop=4
* `\T`   :set expandtab tabstop=8 shiftwidth=8 softtabstop=4
* `\M`   :set noexpandtab tabstop=8 shiftwidth=4 softtabstop=4
* `\m`   :set expandtab tabstop=2 shiftwidth=2 softtabstop=2
* `,f`     :CtrlP
* `,F`     :CtrlPCurWD
* `,b`     :CtrlPBuffer
* `,m`     :CtrlPMRUFiles
* `,M`     :CtrlPMixed
* `,t`     :CtrlPTag
* `,ev`    Edit ~/.vimrc
* `,sv`    Save and reload ~/.vimrc
* Highlight end of line whitespaces
* `,S`     Remove end of line extra whitespaces
* `:SudoWrite` Write a privileged file with sudo
* `:Locate`    Run locate and load the results into the quickfix list.
* `:Find`      Run find and load the results into the quickfix list.

### Plugins
* https://github.com/tpope/vim-sensible
* https://github.com/tpope/vim-scriptease
* https://github.com/tpope/vim-eunuch
* https://github.com/tpope/vim-fugitive
* https://github.com/tpope/vim-surround
* https://github.com/kien/ctrlp.vim


## Notes

### Add submodule
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

Source: http://stackoverflow.com/questions/1260748/how-do-i-remove-a-git-submodule#1260982

