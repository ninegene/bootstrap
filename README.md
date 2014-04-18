## Installation

```bash
cd ~
git clone https://github.com/readytouch/dotfiles.git
cd dotfiles
./bootstrap.sh --install
```

`bootstrap.sh` updates submodules, installs dependencies packages and backup existing dotfiles (.vimrc, config.fish, .profile, .aliases etc.)
 in user home directory and create soft links from `dotfiles`

To update, do `git pull` and execute `bootstrap.sh` again
```bash
cd ~/dotfiles
git pull
./bootstrap.sh
```

## Vim

### Useful Commands

* `gg` and `G` Go to the begin/end of the file
* `<n>G` Go to line number n e.g. `10G` to go to line number 10
* `gi` Jump to last edited position to start editing
* `g;` Jump to last edited position
* `'.` Jump back to last edited line
* `Ctrl-O` and `Ctrl-I` Jump to previous(old) position and next position between buffers
* `%` Jump to next matching {..}, (..), etc.
* `*` and `#` Search for the word under the cursor forward/backward
* `:%s/old/new/gc` Substitute "old" with "new" from start to end of the file with confirmation
* `:%g/my/s/old/new/g` For every line containing "my" substitute all "old" with "new"


* `J` Joins two lines
* `~` Change case
* `.` Repeat last command
* `>` and `<` (visual mode) Indent and unindent lines
* `==` (visual mode) Fix line indent
* `f<char>` Move to the next instance of a particular character (cursor after character) on the current line
* `t<char>` Move to the next instance of a particular character (cursor before character) on the current line
* `cf(`, `vf(` `yf(` and`df(` Change/Select/copy/delete text up to "(" including it
* `ct(`, `vt(` `yt(` and`dt(` Change/Select/copy/delete text up to "(" excluding it
* `ciW`, `viW`, `yiW` and `diW` Change/select/copy/delete inner word
* `ci"`, `ci'`, `ci{` and `ci(` Change inner text between doulbe quotes, single quotes, curly braces and brackets
* `vi"`, `vi'`, `vi{` and `vi(` Select inner text between doulbe quotes, single quotes, curly braces and brackets
* `yi"`, `yi'`, `yi{` and `yi(` Copy inner text between doulbe quotes, single quotes, curly braces and brackets
* `C` Change remaining part of line
* `cc` Change the whole line
* `D` or `dd` Delete/cut line
* `Y` or `yy` Copy line
* `"ayi{` Copy text betwen curly braces in to register `a`
* `"ap` Paste from register `a`
* `:reg` Show yank/copy registers
* `Ctrl-R<register>` (insert, command) Paste from register. See `:h i_CTRL-R` and `:h c_CTRL-R`



#### More Info
* http://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim?rq=1

### Mappings

### Line Operations
* `[<Space>` Add [count] blank lines above cursor
* `]<Space>` Add [count] blank lines below cursor
* `[e` and `]e` to move current line/selected block of lines up and down

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
* `[n`   Go to previous SCM conflict markter. Try `d[n` inside a confict
* `]n`   Go to next SCM conflict markter. Try `d]n` inside a confict

#### Copy and Paste
* `Ctrl-C` to copy in virtual mode
*  `*` and `#` to search current selection in virtual mode
* `gv` to vimgrep after the selected text in virtual mode
* `<F2>` Toggle paste mode (which allow to paste without formatting/indenting) in normol and insert mode

#### Toggle
* `,tt`  Toggle tag bar (need to have ctags installed)
* `\t`   :set expandtab tabstop=4 shiftwidth=4 softtabstop=4
* `\T`   :set expandtab tabstop=2 shiftwidth=2 softtabstop=2
* `\m`   :set expandtab tabstop=8 shiftwidth=8 softtabstop=4
* `\M`   :set noexpandtab tabstop=8 shiftwidth=4 softtabstop=4
* `gc{motion}` Toggle comments on sepcified motion
* `gcc`        Toggle comment on the current line
* `gc`         Toggle comment on selected lines in virtual mode
* `[oh`, `]oh` and `coh` to turn on, turn off and toggle `hlsearch`        highlight search terms
* `[ow`, `]ow` and `cow` to turn on, turn off and toggle `wrap`            line wrap
* `[ot`, `]ot` and `cot` to turn on, turn off and toggle `textwidth`       between 0 and 99 (break
  long line after textwdith. 0 means don't break long line)
* `[om`, `]om` and `com` to turn on, turn off and toggle `colorcolumn`     right margin column
* `[on`, `]on` and `con` to turn on, turn off and toggle `number`          line number
* `[or`, `]or` and `cor` to turn on, turn off and toggle `relativenumber`  relative line number
* `[oi`, `]oi` and `coi` to turn on, turn off and toggle `ignorecase`      ignore case search
* `[os`, `]os` and `cos` to turn on, turn off and toggle `spell`           spell check
* `[oc`, `]oc` and `coc` t turn on, turn off and toggle `cursorline`       current line cursor
* `[ou`, `]ou` and `cou` to turn on, turn off and toggle `cursorcolumn`    current column cursor
* `[ou`, `]ou` and `cou` to turn on, turn off and toggle `cursorline` and `curosrcolumn` (x as in crosshairs)

#### Search files to open/edit
* `,n`   :NERDTreeToggle     - Toggle open file browser
* `,f`   :CtrlP              - find file mode (files in the directory of current file and project root of `.git` `.hg` `.svn` `.bzr`
* :CtrlP [starting-dirctory] - file mode (files in directory specify)
* `,F`   :CtrlPCurWD         - file mode (files in current working directory)
* `,m`   :CtrlPMRUFiles      - MRU file mode
* `,M`   :CtrlPMixed         - file, buffer, MRU
  * `<F5>` - purge the cache for the current directory
  * `<Ctrl-f>` and `<Ctrl-b>` to cycle between mode
  * `<Ctrl-d>` to switch to filename search instead of full path
  * `<Ctrl-r>` to switch to regexp mode
  * `..` to go up the directory tree by on or multiple level
  * `<Ctrl-j>` and `<Ctrl-k>` or `<Down>` and `<Up>` to navigate the result list
  * `<Ctrl-t>`, `<Ctrl-v>` and `<Ctrl-x>` to open selected entry in a new tab or vertical split and horizontal split
* `,t` and `,T`  Open/close the catalog window of all tab pages (BufferGator plugin)
* `,b` and `,B`  Open/close the catalog window of all buffers (BufferGator plugin)
  * `j` and `k` to move the selection to the next and previous buffer
  * `<ENTER>` to edit the selected buffer in the previous window
  * `<Ctrl-v>` to edit the selected buffer in a new vertical split
  * `<Ctrl-s>` to edit the selected buffer in a new horizontal split
  * `<Ctrl-t>` to edit the selected buffer in a new tab page
  * `<Ctrl-n>` (`<Space>`) and `<Ctrl-p>` (`<Ctrl-Space>`) to open the next and previous buffer in succession
  * `cs` to sort display regimes/filename
  * `cd` to change display regimes (between filename only, full path, and filename and directory)
  * `r` to rebuild/refresh index
  * `d` to delete the selected buffer
  * `x` to wipe the selected buffer
  * `q` to quit the index/catalog window
* `[b`   :bprevious - Go to previous buffer
* `]b`   :bnext - Go to next buffer

#### Search text within files
* `:Ack [options] {pattern} [{directory}]`
* In Ack quickfix window:
  * `o`    to open (same as enter)
  * `go`   to preview file (open but maintain focus on ack.vim results)
  * `t`    to open in new tab
  * `T`    to open in new tab silently
  * `h`    to open in horizontal split
  * `H`    to open in horizontal split silently
  * `v`    to open in vertical split
  * `gv`   to open in vertical split silently
  * `q`    to close the quickfix window

#### Folding
* `zf#j`      Creates a fold from the cursor down # lines
* `zf/string` Creates a fold from the cursor to string
* `zj`        Moves the cursor to the next fold
* `zk`        Moves the cursor to the previous fold
* `zo`        Opens a fold at the cursor
* `zO`        Opens all folds at the cursor
* `zm`        Increases the foldlevel by one
* `zM`        Closes all open folds
* `zr`        Decreases the foldlevel by one
* `zR`        Decreases the foldlevel to zero -- all folds will be open
* `zd`        Deletes the fold at the cursor
* `zE`        Deletes all folds
* `[z`        Move to start of open fold
* `]z`        Move to end of open fold

### Plugins

#### For file editing
* https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
* https://raw.github.com/tpope/vim-repeat/master/autoload/repeat.vim
* https://github.com/tpope/vim-sensible
* https://github.com/tpope/vim-scriptease
* https://github.com/tpope/vim-eunuch
* https://github.com/tpope/vim-unimpaired
* https://github.com/tpope/vim-endwise
* https://github.com/gcen/ctrlp.vim
* https://github.com/bling/vim-airline
* https://github.com/mileszs/ack.vim
* https://github.com/scrooloose/nerdtree
* https://github.com/mhinz/vim-startify

#### For git
* https://github.com/tpope/vim-fugitive
* https://github.com/airblade/vim-gitgutter

#### For code editing
* https://github.com/scrooloose/syntastic
* https://github.com/jeetsukumaran/vim-buffergator
* https://github.com/sjl/gundo.vim (Vim 7.3+)
* https://github.com/scrooloose/nerdcommenter
* https://github.com/tomtom/tcomment_vim
* https://github.com/ervandew/supertab
* https://github.com/majutsushi/tagbar
* https://github.com/tpope/vim-surround
* https://github.com/jiangmiao/auto-pairs
* https://github.com/plasticboy/vim-markdown

#### For python
* https://github.com/nvie/vim-flake8
* https://github.com/davidhalter/jedi-vim
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
git submodule add git://github.com/gcen/ctrlp.vim.git .vim/bundle/ctrlp.vim
git submodule add https://github.com/bling/vim-airline.git .vim/bundle/vim-airline
git submodule add https://github.com/airblade/vim-gitgutter.git .vim/bundle/vim-gitgutter
git submodule add https://github.com/majutsushi/tagbar.git .vim/bundle/tagbar
git submodule add https://github.com/mileszs/ack.vim .vim/bundle/ack.vim
git submodule add https://github.com/scrooloose/nerdcommenter.git .vim/bundle/nerdcommenter
git submodule add https://github.com/scrooloose/syntastic.git .vim/bundle/syntastic
git submodule add https://github.com/scrooloose/nerdtree.git .vim/bundle/nerdtree
git submodule add https://github.com/tomtom/tcomment_vim.git .vim/bundle/tcomment_vim
git submodule add https://github.com/jeetsukumaran/vim-buffergator.git .vim/bundle/vim-buffergator
git submodule add https://github.com/sjl/gundo.vim.git .vim/bundle/gundo.vim
git submodule add https://github.com/ervandew/supertab.git .vim/bundle/supertab
git submodule add https://github.com/klen/python-mode.git .vim/bundle/python-mode
git submodule add https://github.com/tpope/vim-unimpaired.git .vim/bundle/vim-unimpaired
git submodule add https://github.com/tpope/vim-endwise.git .vim/bundle/vim-endwise
git submodule add https://github.com/jiangmiao/auto-pairs.git .vim/bundle/auto-pairs
git submodule add https://github.com/plasticboy/vim-markdown.git .vim/bundle/vim-markdown
git submodule add https://github.com/mhinz/vim-startify.git .vim/bundle/vim-startify
git submodule add https://github.com/nvie/vim-flake8.git .vim/bundle/vim-flake8
git submodule add https://github.com/davidhalter/jedi-vim.git .vim/bundle/jedi-vim
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

### Useful Commands
```bash
$ sudo !!
Run the last command as root when you forget to use sudo for a command

$ cd -
# Go back to last directory

$ > filename.log
Delete content of filename.log

$ ^old^new
Run previous command replacing first occurence "old" with "new". Arguments default to empty string.
E.g.
    Correct user
    $ ssh usar@host
    $ ^usar^user
    Remove extra "z"
    $ ssh user@hostz
    $ ^z

Copy the content of the web page to clipboard
Mac:
$ curl https://news.ycombinator.com | pbcopy
Linux:
$ curl https://news.ycombinator.com | xclip

Open file with default appliaction base on file extention
Mac:
$ open doc.pdf
Linux:
$ xdg-open doc.pdf

mrt, better than traceroute and ping combined
$ mtr google.com

Download all mp4's listed in an html page
$ wget -r -l1 -H -t1 -nd -N -np -A.mp3 -erobots=off [url of website]

Hold/unhold a package using apt-mark
$ sudo apt-mark hold package_name
$ sudo apt-mark unhold package_name

```

#### References
* http://www.commandlinefu.com
* http://askubuntu.com/questions/18654/how-to-prevent-updating-of-a-specific-package
