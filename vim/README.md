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
* `ciw`, `ci"`, `ci'`, `ci{` and `ci(` Change inner word, inner text between double quotes, single quotes, curly braces and brackets
* `viw`, `vi"`, `vi'`, `vi{` and `vi(` Select inner word, inner text text between double quotes, single quotes, curly braces and brackets
* `yiw`, `yi"`, `yi'`, `yi{` and `yi(` Copy inner word, inner text between double quotes, single quotes, curly braces and brackets
* `C` Change remaining part of line
* `cc` Change the whole line
* `D` or `dd` Delete/cut line
* `Y` or `yy` Copy line
* `"ayy` Copy current line to register `a`
* `"ayi{` Copy text betwen curly braces in to register `a`
* `"ap` Paste from register `a`
* `:reg` Show yank/copy registers
* `Ctrl-R<register>` (insert, command) Paste from register. See `:h i_CTRL-R` and `:h c_CTRL-R`

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

### Plugins

#### For file editing
* https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
* https://github.com/tpope/vim-repeat.git
* https://github.com/tpope/vim-scriptease
* https://github.com/tpope/vim-eunuch
* https://github.com/tpope/vim-unimpaired
* https://github.com/bling/vim-airline
* https://github.com/tpope/vim-surround
* https://github.com/mileszs/ack.vim
* https://github.com/sjl/gundo.vim
* https://github.com/tomtom/tcomment_vim

#### Syntax
* https://github.com/scrooloose/syntastic
* https://github.com/plasticboy/vim-markdown

#### Coding
* https://github.com/majutsushi/tagbar
* https://github.com/ervandew/supertab

#### File browsing
* https://github.com/mhinz/vim-startify
* https://github.com/scrooloose/nerdtree
* https://github.com/kien/ctrlp.vim

#### For git
* https://github.com/tpope/vim-fugitive
* https://github.com/airblade/vim-gitgutter

#### For python
* https://github.com/davidhalter/jedi-vim


