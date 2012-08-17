"
" Based on:
" http://github.com/nvie/vimrc/blob/master/vimrc
" http://github.com/mitechie/pyvim/blob/master/.vimrc
" http://amix.dk/vim/vimrc.html
" and various places (books, articles, blog posts etc.)
"
" Shortcuts and Help {{{
" ==================================================
" Command Mode
" w!!          - Sudo to write
" m<char>      - Mark the position
" '<char>      - Return to the marked position (line and column)
" ,S           - Clean all end of line extra whitespace
" ,al          - Align left
" ,ar          - Align right
" ,ac          - Align center
" ,y           - Copy/yank to the OS clipboard
" ,yy          - Copy/yank the current line to the OS clipboard
" ,p           - Paste from the OS clipboard after the current position
" ,P           - Paste from the OS clipboard before the current position
" ,d           - Delete without adding it to the yanked stack
" ,dd          - Delete the current line without adding it to the yanked stack
" ,r           - Show the copied/cut registers
" ,0           - Paste from register 0
" ...
" ,9           - Paste from register 9

" <C-H>        - Move to left split window
" <C-J>        - Move to below split window
" <C-K>        - Move to above split window
" <C-L>        - Move to right split window
" +            - Increase the current split window horizontally
" -            - Decrease the current split window horizontally
" <M-,>        - Increase the current split window vertically - Alt->
" <M-.>        - Decrease the current split window vertically - Alt-<
" <C-W><C-R>   - Rotate split window to next spot
" <C-W><C-X>   - Swap split window with current one
" <F4>         - Close the current split window

" Insert Mode
" <F2>         - Toggle paste mode, where you can paste mass data that won't be autoindented
" <C-W><C-H>   - Move to left split window
" <C-W><C-J>   - Move to below split window
" <C-W><C-K>   - Move to above split window
" <C-W><C-L>   - Move to right split window

" Virtual Mode
" *            - Search for the current selection forward
" #            - Search for the current selection backward
" p            - Replace the selected text with the yank register
" ,d           - Delete without adding it to the yanked stack (Map to "_d which is black hole register)
" ,ddd         - Delete the current line without adding it to the yanked stack

" ,ev          - Open the vimrc file (:e $MYVIMRC)
" ,sv          - Save and reload the vimrc file

" :nohls       - Clear highlighted search terms
" :set nohls   - Turn off highlighted search
" :set hls     - Turn on highlighted search

" :set all     - Show all options
" :version
" :echo expand('~')
" :echo $HOME
" :echo $VIM
" :echo $VIMRUNTIME
" :echo $MYVIMRC
" :echo $MYGVIMRC
" :echo &runtimepath
" :echo &rtp

" :e <file>    - Open file in current window
" :sp <file>   - Open file in horizontal split window
" :vsp <file>  - Open file in vertical split window
" :Ex <dir>    - Explore (Split horizontal if current file is modified)
" :Ex! <dir>   - Explore (Split vertical if current file is modified)
" :Sex <dir>
" :Sex! <dir>
" :Rex         - Return to Explorer

" :r <file>    - Insert the file content below the cursor
" :0r <file>   - Insert the file content at the beginning of current file
" :r !<cmd>    - Insert the command output below the cursor
" :$r !<cmd>   - Insert the command output at the end of current file

" zf#j         - Creates a fold from the cursor down # lines
" zf/string    - Creates a fold from the cursor to string
" zj           - Moves the cursor to the next fold
" zk           - Moves the cursor to the previous fold
" zo           - Opens a fold at the cursor
" zO           - Opens all folds at the cursor
" zm           - Increases the foldlevel by one
" zM           - Closes all open folds
" zr           - Decreases the foldlevel by one
" zR           - Decreases the foldlevel to zero -- all folds will be open
" zd           - Deletes the fold at the cursor
" zE           - Deletes all folds
" [z           - Move to start of open fold
" ]z           - Move to end of open fold

" Find "Users" in *.js
" :vimgrep /Users/ **/*.js

" Find "Users" in *.js and *.html
" :vimgrep /Users/ **/*.js **/*.html
  " }}}

" General {{{
" ==================================================
" Use vim settings, rather then vi settings
" This must be first because it changes other options as a side effect
set nocompatible

" Use pathogen to easily modify the runtime path to include all plugins under the ~/.vim/bundle
" Need to invoke the pathogen functions before invoking "filetype plugin indent on" if you want it to load ftdetect files.
filetype off
try
    call pathogen#runtime_append_all_bundles()
    call pathogen#helptags()
catch
endtry

filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins
filetype indent on

" Change the mapleader from \ to ,
let mapleader=","
let g:mapleader=","

" Sudo to write
cmap w!! w !sudo tee % >/dev/null
" }}}

" Editor Navigation {{{
" ==================================================
map <F1> <Esc>                      " sometimes mis-type F1 when trying to type Esc

" Remap j and k to act as expected when used on long wrapped lines
nnoremap j gj
nnoremap k gk

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line and ` jumps to the marked line and column
nnoremap ' `
nnoremap ` '

syntax on                       " Enable lexical/syntax highlighting
"set number                      " Show line numbers
set ruler                       " Show the cursor position all the time
set showmode                    " Always show what mode we're currently editing in
set cmdheight=2                 " Use a status bar that is 2 rows high
set shortmess=atI               " Abbreviate messages
set showcmd                     " Show (partial) command in the last line of the screen. This also shows visual selection info
set visualbell                  " Use visual bell instead of beeping
set noerrorbells                " Don't beep
set listchars=tab:<-,trail:-    " Use :l to see invisible characters on current line or :%l on all lines
"set cursorline                  " Hightlight the screen line of the curson
set backspace=indent,eol,start  " Allow backspacing over everything in insert mode
set whichwrap=b,s,<,>,[,]       " Move freely between files
set showmatch                   " Show matching parenthesis
set matchtime=2                 " How many tenths of a second to blink
set matchpairs+=<:>             " Show matching <> (html mainly) as well

" Folding
"set foldenable                  " Enable folding
"set foldcolumn=2                " Add a fold column
"set foldmethod=marker           " Detect triple-{ style fold markers
                                " Which commands trigger auto-unfold
"set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

" Search
set ignorecase                  " Ignore case when searching
set smartcase                   " Ignore case if search pattern is all lowercase, case-sensitive otherwise
set incsearch                   " Show search matches as you type
set hlsearch                    " Highlight search terms. Use :nohls to remove highlighted search terms
set magic                       " Match literally for some characters in regular expression

" Use ,/ to clear highlighted search terms
map <leader>/ :nohls<CR>

" Highlight end of line whitespace.
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" Clean all end of line extra whitespace with ,S
:nnoremap <silent><leader>S :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Tab Completion
set wildmenu                    " Make tab completion for files/buffers to act like bash
set wildmode=list:full          " Show a list when pressing tab and complete first full match
set wildignore="*.swp,*.pyc,*.class

set title                       " Change the terminal's title
set ttyfast                     " Smoother changes. More characters will be sent to the screen for redrawing
set lazyredraw                  " Don't update the display while executing macros
" }}}

" Editor Formatting {{{
" ==================================================
"set nowrap                      " Don't wrap lines
"set nowrapscan                  " Don't wrap line if too long
set textwidth=120

set autoindent                  " Always set autoindenting on
set smartindent
set cindent
set expandtab                   " Tabs are converted to spaces
set softtabstop=4               " Number of spaces that a <Tab> counts for while performing editing operations, like inserting a <Tab> or using <BS>
set tabstop=4
set shiftwidth=4                " Number of spaces to use for autoindenting
set shiftround                  " Use multiple of shiftwidth when indenting with '<' and '>'
set smarttab                    " Insert tabs on the start of a line according to shiftwidth, not tabstop

set history=500                 " Remember more commands and search history

" Move current line/selected block of lines up and down
noremap <C-S-Up> :m-2<CR>==
noremap <C-S-Down> :m+<CR>==
inoremap <C-S-Up> <Esc>:m-2<CR>==gi
inoremap <C-S-Down> <Esc>:m+<CR>==gi
vnoremap <C-S-Up> :m-2<CR>gv=gv
vnoremap <C-S-Down> :m'>+<CR>gv=gv

" Qick alignment of text (with ,al ,ar ,ac)
nmap <leader>al :left<CR>
nmap <leader>ar :right<CR>
nmap <leader>ac :center<CR>
" }}}

" Yanking and Pasting {{{
" ==================================================
" When in insert mode, press <F2> to go to paste mode, where you can paste mass data that won't be autoindented
set pastetoggle=<F2>

" Make p in visual mode replace the selected text with the yank register
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the yanked stack (also, in visual mode)
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d

" Yank/paste to the OS clipboard with ,y and ,p
nmap <leader>y "+y
nmap <leader>p "+p
nmap <leader>P "+P

" Show the registers from things cut/yanked
nmap <leader>r :registers<CR>

" Map the various registers to a leader shortcut for pasting from them
nmap <leader>0 "0p
nmap <leader>1 "1p
nmap <leader>2 "2p
nmap <leader>3 "3p
nmap <leader>4 "4p
nmap <leader>5 "5p
nmap <leader>6 "6p
nmap <leader>7 "7p
nmap <leader>8 "8p
nmap <leader>9 "9p
" }}}

" File Browsing and Windows {{{
" ==================================================

" Default file types
set ffs=unix,dos,mac

" Sets how vim shall represent characters internally
set encoding=utf-8
set termencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,latin1

" Set to auto read when a file is changed from the outside
set autoread

" Auto change the directory to the current file I'm working on
set autochdir

" Hide buffers instead of closing them.
" This means that the current buffer can be put to background without being written and
" marks and undo history are preserved
set hidden
set switchbuf=useopen           " Reveal already opened files from the quickfix windows
set winminheight=0              " Show only filename for minimized window
set winheight=10
set laststatus=2                " Always put a status line in even if there is only one window
set modeline                    " Allow files to include a 'mode line' to override vim defaults
set modelines=5                 " Check the first 5 lines for a modeline
set scrolloff=4                 " Keep 4 lines off the edges of the screen when scrolling
set virtualedit=all             " Allow the cursor to go into "invalid" places
"set mouse=a                     " Enable using the mouse if terminal emulator supports it (xterm does)

set nobackup                    " Do not keep backup files
set nowb
set noswapfile

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e ~/.vimrc<CR><C-W>_
nmap <silent> <leader>sv :w!<CR>:so ~/.vimrc<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Ctrl-jklm to move to another split window
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l

" Also make it to work in insert mode (<C-o> makes next cmd happen as if in command mode )
imap <C-W> <C-O><C-W>

" Use + and - to resize horizontal splits
map - <C-W>-
map + <C-W>+

" Use Alt-< and Alt-> to resize vertical splits
map <M-,> <C-W><
map <M-.> <C-W>>

" F4 to close current window
noremap <F4> <Esc>:close<CR><Esc>

" Complete whole filenames/lines with a quicker shortcut key in insert mode
imap <C-F> <C-X><C-F>
imap <C-L> <C-X><C-L>

" }}}

" Plugins {{{
" ===========

" CloseTag: Intelligently close HTML tags for html and xml files only
" http://mirnazim.org/writings/vim-plugins-i-use/
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim

" Command-t: Pattern based file opener
noremap <leader>o <Esc>:CommandT<CR>
noremap <leader>O <Esc>:CommandTFlush<CR>
noremap <leader>m <Esc>:CommandTBuffer<CR>

" Tagbar: Awesome source code [tag]browsing
let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>

" Solarized Colorscheme
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized

" https://github.com/pangloss/vim-javascript
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
" }}}
