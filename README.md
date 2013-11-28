## Installation

```bash
cd ~
git clone --recursive https://github.com/ninegene/dotfiles.git
```
or
```bash
cd ~
git clone https://github.com/ninegene/dotfiles.git
cd ~/dotfiles && git submodule update --init --recursive
```
```bash
`bootstrap.sh` backup existing dotfiles (.vimrc, config.fish, .profile, .aliases etc.)
 in user home directory and create soft links from `dotfiles`
```bash
~/dotfile/bootstrap.sh
```
To update, do `git pull` and execute `bootstrap.sh` again

## Vim

### Mappings

* `Ctrl-Shift-Up` and `Ctrl-Shift-Down` to move current line/selected block of lines up and down
* `,ev`  Edit ~/.vimrc
* `,sv`  Save and reload ~/.vimrc
* `,S`   Remove end of line whitespaces are hilighted in red
* `:SudoWrite` Write a privileged file with sudo
* `:Locate`    Run locate and load the results into the quickfix list.
* `:Find`      Run find and load the results into the quickfix list.

### Git
* `:Gdiff`            Between current file and the index
* `:Gdiff ~2`         Between current file and 2 commits ago
* `:Gdiff [revision]` Between current file and revision
* `:GitGutterDisable`
* `:GitGutterEnable`
* `:GitGutterToggle`
* `]h`, `[h` to jump to next and previous hunk (modified line) in Git Gutter

#### Copy and Paste
* `Ctrl-C` to copy in virtual mode
* `p` in visual mode replace the selected text with the yank register
* `,d` (or `,dd` or `,dj` or `20,dd`) to delete without adding it to the yanked stack
* Yank/paste to the OS clipboard with `,y`, `,P` and `,p`
* `,r` to show registers for text cut and yanked
* * and `#` to search current selection in virtual mode
* `gv` to vimgrep after the selected text in virtual mode
* `<F2>` Toggle paste mode (which allow to paste without formatting/indenting) in normol and insert mode

#### Toggle
* `\w`   Toggle wrap
* `\n`   Toggle show line number
* `\tw`  Toggle textwidth between 0 and 99 - used to break long line that is being inserted
* `\t`   :set expandtab tabstop=4 shiftwidth=4 softtabstop=4
* `\T`   :set expandtab tabstop=8 shiftwidth=8 softtabstop=4
* `\M`   :set noexpandtab tabstop=8 shiftwidth=4 softtabstop=4
* `\m`   :set expandtab tabstop=2 shiftwidth=2 softtabstop=2
* `\tt`  Toggle tag bar
* `gc{motion}` Toggle comments on sepcified motion
* `gcc`        Toggle comment on the current line
* `gc`         Toggle comment on selected lines in virtual mode

#### Search files to open/edit
* `,f`   :CtrlP              - find file mode (files in the directory of current file and project root of `.git` `.hg` `.svn` `.bzr`
* :CtrlP [starting-dirctory] - file mode (files in directory specify)
* `,F`   :CtrlPCurWD         - file mode (files in current working directory)
* `,B`   :CtrlPBuffer        - buffer mode
* `,m`   :CtrlPMRUFiles      - MRU file mode
* `,M`   :CtrlPMixed         - file, buffer, MRU
  * `<F5>` - purge the cache for the current directory
  * `<Ctrl-f>` and `<Ctrl-b>` to cycle between mode
  * `<Ctrl-d>` to switch to filename search instead of full path
  * `<Ctrl-r>` to switch to regexp mode
  * `..` to go up the directory tree by on or multiple level
  * `<Ctrl-j>` and `<Ctrl-k>` or `<Down>` and `<Up>` to navigate the result list
  * `<Ctrl-t>`, `<Ctrl-v>` and `<Ctrl-x>` to open selected entry in a new tab or vertical split and horizontal split
* `,b`   Open a window listing all buffer (BufferGator plugin)
  * `<ENTER>` to edit the selected buffer in the previous window
  * `<Ctrl-v>` to edit the selected buffer in a new vertical split
  * `<Ctrl-s>` to edit the selected buffer in a new horizontal split
  * `<Ctrl-t>` to edit the selected buffer in a new tab page
* `[b` and `]b` to flip through the most-recently used buffer stack without opening buffer listing

#### Search text within files
* `:Ack [options] {pattern} [{directory}]`
* In Ack auickfix window:
  * `o`    to open (same as enter)
  * `go`   to preview file (open but maintain focus on ack.vim results)
  * `t`    to open in new tab
  * `T`    to open in new tab silently
  * `h`    to open in horizontal split
  * `H`    to open in horizontal split silently
  * `v`    to open in vertical split
  * `gv`   to open in vertical split silently
  * `q`    to close the quickfix window

### Plugins

#### For file editing
* https://github.com/tpope/vim-sensible
* https://github.com/tpope/vim-scriptease
* https://github.com/tpope/vim-eunuch
* https://github.com/kien/ctrlp.vim
* https://github.com/bling/vim-airline
* https://github.com/mileszs/ack.vim
* https://github.com/scrooloose/nerdtree.git
* https://github.com/scrooloose/nerdcommenter.git
* https://github.com/tomtom/tcomment_vim.git
* https://github.com/jeetsukumaran/vim-buffergator
* https://github.com/sjl/gundo.vim (Vim 7.3+)
* https://github.com/ervandew/supertab

#### For git
* https://github.com/tpope/vim-fugitive
* https://github.com/airblade/vim-gitgutter

#### For code editing (as IDE)
* https://github.com/majutsushi/tagbar
* https://github.com/tpope/vim-surround
* https://github.com/Raimondi/delimitMate

#### For python
* https://github.com/kevinw/pyflakes-vim
* https://github.com/klen/python-mode

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
git submodule add https://github.com/bling/vim-airline.git .vim/bundle/vim-airline
git submodule add https://github.com/airblade/vim-gitgutter.git .vim/bundle/vim-gitgutter
git submodule add https://github.com/majutsushi/tagbar.git .vim/bundle/tagbar
git submodule add https://github.com/mileszs/ack.vim .vim/bundle/ack.vim
git submodule add https://github.com/scrooloose/nerdcommenter.git .vim/bundle/nerdcommenter
git submodule add https://github.com/scrooloose/nerdtree.git .vim/bundle/nerdtree
git submodule add https://github.com/tomtom/tcomment_vim.git .vim/bundle/tcomment_vim
git submodule add https://github.com/jeetsukumaran/vim-buffergator.git .vim/bundle/vim-buffergator
git submodule add https://github.com/kevinw/pyflakes-vim.git .vim/bundle/pyflakes-vim
git submodule add https://github.com/kevinw/pyflakes-vim.git .vim/bundle/pyflakes-vim
git submodule add https://github.com/Raimondi/delimitMate .vim/bundle/delimitMate
git submodule add https://github.com/sjl/gundo.vim.git .vim/bundle/gundo.vim
git submodule add https://github.com/ervandew/supertab.git .vim/bundle/supertab
git submodule add https://github.com/klen/python-mode.git .vim/bundle/python-mode
git submodule update --init --recursive
```

### Change submodule url
* Modify your `.gitmodule` file to use the new URL
* Run `git submodule sync`
Source: http://stackoverflow.com/questions/14404704/how-do-i-replace-a-git-submodule-with-another-repo

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

### Install Fish Shell
```bash
sudo apt-add-repository ppa:fish-shell/release-2
sudo apt-get update
sudo apt-get install fish
```
Make Fish shell as default shell:
```bash
chsh -s /usr/bin/fish
```
Create Fish config directory:
```bash
mkdir -p ~/.config/fish
```
Create initial config file:
```bash
vi ~/.config/fish/config.fish
```

