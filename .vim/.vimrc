" Only if not set before:
if &compatible
    " Use vim settings, rather then vi settings
    set nocompatible
endif

filetype off

" Disable loading plugins in the list
let g:pathogen_disabled = [ 'pathogen', 'python-mode', 'vim-buffergator', 'vim-flake8', 'pyflakes-vim', 'delimiMate' ]

if has('gui_running')
   set guioptions+=a
   " Allow mouse in help file (use "g<LeftMouse>" to jump to tags), normal and visual mode
   set mouse=a
endif

"if !has('gui_running')
"  call add(g:pathogen_disabled, 'someplugin')
"endif

if v:version < '703'
  call add(g:pathogen_disabled, 'gundo')
endif

call pathogen#infect()                      " load plugins under .vim/bundle
call pathogen#helptags()                    " load plugins help files or :Helptags

filetype plugin indent on
syntax on

" Change the mapleader from \ to ,
let mapleader = ","
let g:mapleader = ","

" http://stackoverflow.com/questions/3776117/vim-what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-map

" https://github.com/tpope/vim-sensible
" :Vtabedit plugin/sensible.vim
"  'backspace' - Backspace through anything in insert mode.
"  'incsearch' - Start searching before pressing enter.
"  'listchars' - Makes :set list (visible whitespace) prettier.
"  'scrolloff' - Always show at least one line above/below the cursor.
"  runtime! macros/matchit.vim - Load the version of matchit.vim that ships with Vim.

" https://github.com/tpope/vim-scriptease
" :Vtabedit plugin/scriptease.vim
"  :PP       - Pretty print.
"  :Runtime  - Reload runtime files. Like :runtime!, but it unlets any include guards first.
"  :Disarm   - Remove a runtime file's maps, commands, and autocommands, effectively disabling it.
"  :Scriptnames - Load :scriptnames into the quickfix list.
"  :Verbose  - Capture the output of a :verbose invocation into the preview window.
"  :Time     - Measure how long a command takes.
"  :Breakadd - Like its lowercase cousin, but makes it much easier to set breakpoints inside functions.
"              Also :Breakdel.
"  :Vedit    - Edit a file relative the runtime path. For example, :Vedit plugin/scriptease.vim.
"              Also, :Vsplit, :Vtabedit, etc. Extracted from pathogen.vim.
"  K         - Look up the :help for the VimL construct under the cursor.
"              Press K on an option (or command, or function) to jump to its documentation.
"  zS        - Show the active syntax highlighting groups under the cursor.
"  g!        - Eval a motion or selection as VimL and replace it with the result. This is handy for
"              doing math, even outside of VimL. It's so handy, in fact, that it probably deserves
"              its own plugin.

" https://github.com/tpope/vim-eunuch
" :Vtabedit plugin/eunuch.vim
"  :Unlink - Delete a buffer and the file on disk simultaneously.
"  :Remove - Like :Unlink, but doesn't require a neckbeard.
"  :Move   - Rename a buffer and the file on disk simultaneously.
"  :Chmod  - Change the permissions of the current file.
"  :Find   - Run find and load the results into the quickfix list.
"  :Locate - Run locate and load the results into the quickfix list.
"  :SudoWrite - Write a privileged file with sudo.
"  :W      - Write every open window. Handy for kicking off tools like guard.

" https://github.com/tpope/vim-fugitive
" :Vtabedit doc/fugitive.txt
" :Vtabedit plugin/fugitive.vim
"  :Gstatus - Press - to add/reset a file's changes, press p to add/reset with --patch option
"  :Gedit   - Edit a file in the index (Also :Gsplit, :Gvsplit, :Gtabedit)
"  :Gwrite  - git add
"  :Gread   - git checkout -- filename that operates on the buffer rather than the filename
"  :Gcommit - git commit
"  :Gdiff   - git diff
"  :Gblame  - git blame
"  :Glog    - git log
"  :Gmove   - git mv
"  :Gremove - git rm
"  :Grep    - git grep
"  :Gbrowse - Open the current file on GitHub or git instaweb if not GitHub repository
"  :Git     - for running any arbitrary command
"  :Git!    - to open the output of a command in a temp file
" More info
" http://vimcasts.org/episodes/fugitive-vim---a-complement-to-command-line-git/
" http://vimcasts.org/episodes/fugitive-vim-working-with-the-git-index/
" http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
" http://vimcasts.org/episodes/fugitive-vim-exploring-the-history-of-a-git-repository/
" http://vimcasts.org/episodes/fugitive-vim-resolving-merge-conflicts-with-vimdiff/
" Auto-clean fugitive buffers to prevent the buffers being swamped with fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" https://github.com/tpope/vim-surround
" :Vtabedit doc/surround.txt
" :Vtabedit plugin/surround.txt
"  Press cs"' inside "Hello world!" to chenge it to 'Hello world!'

" https://github.com/kien/ctrlp.vim
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'ctrlp'
" Show dotfiles
"let g:ctrlp_show_hidden = 1
let g:ctrlp_show_hidden = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]tmp|venv|\.(idea|git|hg|svn|cache|cocoapods|cups|dropbox|filezilla|npm|node-gyp|gvm|m2|macports|pip|grails|Trash)$',
  \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\|\.DS_Store$\',
  \ }
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>F :CtrlPCurWD<CR>
nnoremap <leader>m :CtrlPMRUFiles<CR>
nnoremap <leader>M :CtrlPMixed<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
" nnoremap <leader>t :CtrlPTag<CR>

" :h buffergator
"let g:buffergator_suppress_keymaps=1
"nnoremap <leader>b :BuffergatorOpen<CR>
"nnoremap <leader>t :BuffergatorTabsOpen<CR>
" nnoremap <leader>t :BuffergatorTabsToggle<CR>

" https://github.com/scrooloose/syntastic
" syntastic: error: your shell /usr/local/bin/fish doesn't use traditional
" UNIX syntax for redirections
set shell=/bin/bash
" No automatic checks for python files
" let g:syntastic_mode_map = { 'mode': 'active',
"                                \ 'active_filetypes': [],
"                                \ 'passive_filetypes': ['python'] }
"let g:syntastic_python_checkers = ['flake8', 'pylint']
let g:syntastic_python_checkers = ['flake8']
" https://github.com/scrooloose/syntastic/issues/482
" http://flake8.readthedocs.org/en/latest/warnings.html
"let g:syntastic_python_flake8_args = '--ignore=E501,E225 --max-line-length=99'
let g:syntastic_python_flake8_args = '--ignore=E501 --max-line-length=99'

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list = 1
let g:syntastic_auto_jump = 1
"let g:syntastic_error_symbol = '✗✗'
"let g:syntastic_style_error_symbol = '✗'
"let g:syntastic_warning_symbol = '⚠⚠'
"let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_check_on_open = 1


" https://github.com/majutsushi/tagbar
nnoremap <leader>tt :TagbarToggle<CR>

" https://github.com/tomtom/tcomment_vim
" Default mappings:
" gc{motion} - toggle comments for the region
" gcc - toggle comment for the current line
" gC{motion} - Comment the region
" gCc        - Comment the current line

" (rempa doesn't seem to work well) Remap '<c-_>' to '<c-/>'
"let g:tcommentMapLeader1 = '<c-/>'
" <c-/><c-/> - Comment in normal, insert, and visual mode
" <c-/>b     - Comment block in normal and insert mode
" <c-/>p     - Comment the current inner paragraph in normal and insert mode

" https://github.com/scrooloose/nerdtree
" Open a NERDTree when vim starts up
"autocmd vimenter * NERDTree
" Open a NERDTree when vim starts up if no files were specified
"autocmd vimenter * if !argc() | NERDTree | endif
" Close vim if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
map <leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden=0
let NERDTreeIgnore=['.DS_Store', '\.pyc$', '\.class$', '\.git$[[dir]]', '\.vim$[[dir]]', '\.Trash$[[dir]]']

" https://github.com/sjl/gundo.vim
map <leader>u :GundoToggle<CR>

" https://github.com/ervandew/supertab
" Tab to use OmniCompletion if necessary
let g:SuperTabDefaultCompletionType = "context"

" https://github.com/nvie/vim-flake8
"let g:flake8_ignore="E501"
"let g:flake8_max_line_length=99
" run Flake8 check every time you write/save a Python file
"autocmd BufWritePost *.py call Flake8()

" https://github.com/davidhalter/jedi-vim
"let g:jedi#use_tabs_not_buffers = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>u"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "1"

" https://github.com/klen/python-mode

let g:pymode_virtualenv = 0

" Disable pymode syntax checking
let g:pymode_lint_write = 0
" Don't use textwidth of 80 and other options
let g:pymode_options = 0
let g:pymode_lint_ignore = "E501"

" Disable python code folding
let g:pymode_folding = 0

" Disable rope autocomplete (Use jedi autocomplete)
let g:pymode_rope_vim_completion=0

" Switch to quickfix window
let g:pymode_lint_hold=1

" Jump to first error
"let g:pymode_lint_jump=1
" Hide quickfix window
"let g:pymode_lint_cwindow=0

let g:pymode_run_key='<leader>R'
let g:pymode_breakpoint_key='<leader>B'
nmap <C-S-Enter> :RopeAutoImport<CR>


" https://github.com/plasticboy/vim-markdown/
let g:vim_markdown_folding_disabled=1


" Quickly edit/reload the vimrc file with ,ev and ,sv
nmap <leader>ev :tabedit ~/.vimrc<CR><C-W>_:set textwidth=0<CR>:exe ":echo 'vimrc loaded'"<CR>
nmap <leader>egv :tabedit ~/.gvimrc<CR><C-W>_:set textwidth=0<CR>:exe ":echo 'vimrc loaded'"<CR>
nmap <silent> <leader>sv :w!<CR>:so ~/.vimrc<CR>:exe ":echo 'vimrc reloaded'"<CR>:setlocal nohls!<CR>

" Highlight end of line whitespace.
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" Clean all end of line extra whitespace with ,S
nnoremap <silent><leader>S :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Sometimes mis-type F1 when trying to type Esc
map <F1> <Esc>

" Remap j and k (down and up arrow keys) to act as expected when used on long wrapped lines
nnoremap j gj
nnoremap k gk
map <Down> gj
map <Up> gk

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line and ` jumps to the marked line and column
nnoremap ' `
nnoremap ` '

" Move current line/selected block of lines up and down
" Doesn't work in vim opened inside Ubuntu terminal
noremap <C-S-Up> :m-2<CR>==
noremap <C-S-Down> :m+<CR>==
inoremap <C-S-Up> <Esc>:m-2<CR>==gi
inoremap <C-S-Down> <Esc>:m+<CR>==gi
vnoremap <C-S-Up> :m-2<CR>gv=gv
vnoremap <C-S-Down> :m'>+<CR>gv=gv

" Shift-Enter to go to next line
imap <S-Enter> <Esc>o
nmap <S-Enter> o<Esc>

" Format the entire file
nnoremap <C-M-l> :normal! gg=G``<CR>

" Underline the current line with '='
"nmap <silent> <leader>ul :t.<CR>Vr=

" Toogle list chars / show whitespaces
map \lc :setlocal list!<CR>:set list?<CR>

" Toogle text wrap
map \w :setlocal wrap!<CR>:set wrap?<CR>

" Toogle show line number
map \n :setlocal number!<CR>:set number?<CR>

" Find merge conflict markers
nmap <silent> <leader>cm <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Qick alignment of text (with ,al ,ar ,ac)
nmap <leader>al :left<CR>
nmap <leader>ar :right<CR>
nmap <leader>ac :center<CR>

" Split Window
" ============

" Ctrl-jklm to move to another split window
"map <C-H> <C-W>h
"map <C-J> <C-W>j
"map <C-K> <C-W>k
"map <C-L> <C-W>l

" Also make it to work in insert mode (<C-o> makes next cmd happen as if in command mode )
"imap <C-W> <C-O><C-W>

" Use + and - to resize horizontal splits
" map - <C-W>-
" map + <C-W>+

" Use Alt-< and Alt-> to resize vertical splits
" Doesn't work in vim opened inside Ubuntu terminal
" map <M-,> <C-W><
" map <M-.> <C-W>>

" Adjust viewports to the same size
" map <Leader>= <C-w>=

" F4 to delete current buffer to left behind hidden buffer
" noremap <F4> <Esc>:bdelete<CR><Esc>

" Complete whole filenames/lines with a quicker shortcut key in insert mode
imap <C-F> <C-X><C-F>
imap <C-L> <C-X><C-L>

" Yanking/Copying and Pasting
" ===========================

" When in insert mode, press <F2> to go to paste mode, so that the clipboard won't be autoindented
set pastetoggle=<F2>
" Also in normal mode
nmap <F2> :set paste!<CR>:set paste?<CR>

" Make p in visual mode replace the selected text with the yank register
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Conflict with pymode
" Use ,d (or ,dd or ,dj or 20,dd) to delete without adding it to the yanked stack
"nmap <silent> <leader>d "_d
" Also, in visual mode
"vmap <silent> <leader>d "_d

" Yank/paste to the OS clipboard with ,y and ,P and ,p
nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P

" Ctrl-c to copy selected text in virtual mode
"vnoremap <C-c> "+y

" Replace the current word or visually selected text with the clipboard contents
nnoremap <F5> viw"+p
vnoremap <F5> "+p

"Prompt to enter text to replace current word or the selected text (use register r)
nnoremap <C-h> "ryiw:%s/<C-r>r//gc<Left><Left><Left>
vnoremap <C-h> "ry:%s/<C-r>r//gc<Left><Left><Left>

" Show the registers from things cut/yanked
" Conflict with jedi-vim
"nmap <leader>r :reg<CR>

" Map the various registers to a leader shortcut for pasting from them
"nmap <leader>0 "0p
"nmap <leader>1 "1p
"nmap <leader>2 "2p
"nmap <leader>3 "3p
"nmap <leader>4 "4p
"nmap <leader>5 "5p
"nmap <leader>6 "6p
"nmap <leader>7 "7p
"nmap <leader>8 "8p
"nmap <leader>9 "9p

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

" Source: Michael Naumann
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

" Editor Options
" =============

set number                    " Show line number
set ruler                     " Show the cursor position all the time
set showmode                  " Always show what mode we're currently editing in
"set cmdheight=2               " Use a status bar that is 2 rows high
" Make p in visual mode replace the selected text with the yank register
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

set showcmd                   " Show (partial) command in the last line of the screen
set shortmess=atI             " Abbreviate messages
set visualbell                " Use visual bell instead of beeping
set noerrorbells              " Don't beep

set laststatus=2              " Always show status line

" vimr-airline plugin overwrite statusline set below
set statusline=%<%f\ %h%m%r
set statusline+=\ [buf:#%n]
set statusline+=\ %{fugitive#statusline()}
set statusline+=%=%-14.(%V%)
set statusline+=\ \ byte:[%b][0x%B]
set statusline+=\ \ line:%l/%L
set statusline+=\ \ col:%v
set statusline+=\ \ %P

set autoread                  " Auto read when a file changed from the outside
"set autochdir                " Auto change the directory to the current opened file
autocmd BufEnter * silent! lcd %:p:h

" Command-line Completion (See 'help: wildmenu')
set wildmenu                  " Make tab completion for files/buffers to act like bash
"set wildmode=list:full        " Show a list when pressing tab and complete first full match
"set wildmode=list,full          " See `h: wildmode`
set wildmode=longest,list,full  " See `h: wildmode`
set wildignore="*.swp,*.pyc,*.class

set title                       " Change the terminal's title
set ttyfast                     " Smoother changes. More characters will be sent to the screen for re⇉
set lazyredraw                  " Don't update the display while executing macros

set nowrap

" Text width which is used to break long line that is being inserted
set textwidth=0               " text after this width will be broken when inserted
autocmd FileType python set textwidth=99
nnoremap [ot :set textwidth=99<CR>
nnoremap ]ot :set textwidth=0<CR>
nnoremap cot :let &tw = (&tw ? 0: 99)<CR>:set textwidth?<CR>

" Show right margin column
"set colorcolumn=+1            " highlight right column after textwidth
set colorcolumn=            " highlight right column after textwidth
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey " Set right column color
nnoremap [om :set colorcolumn=+1<CR>
nnoremap ]om :set colorcolumn=<CR>
nnoremap com :let &colorcolumn= (&colorcolumn == '+1' ? '' : '+1')<CR>:set colorcolumn?<CR>

set backspace=indent,eol,start " Allow backspacing over everything in insert mode

" Indent and Tab
set autoindent                " Always set autoindenting on
"set copyindent
set smartindent
set cindent
set expandtab                 " Tabs are converted to spaces
set softtabstop=4             " Number of spaces that a <Tab> counts for while performing editing
                              " operations, like inserting a <Tab> or using <BS>
set tabstop=4                 " See 'help: tapstop'
set shiftwidth=4              " Number of spaces to use for autoindenting
set shiftround                " Use multiple of shiftwidth when indenting with '<' and '>'
set smarttab                  " Insert tabs on the start of a line according to shiftwidth, not tabstop

" Toogle different tab modes
nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap \T :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
nmap \m :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
" Confirm to PEP8
" autocmd FileType python set tabstop=4 softtabstop=4 expandtab shiftwidth=4 cinwords=if,elif,else,for,while,try,except,finally,def,class augroup END
" Show matching pairs
set showmatch                 " Show matching parenthesis
set matchtime=2               " How many tenths of a second to blink
set matchpairs+=<:>           " Also match <> mainly for html tag
autocmd FileType c,cpp,java,js,groovy set mps+==:; " Jump between '=' and ';' for some file types

set history=1000              " Remember more commands and search history
"
" Folding
"set foldenable               " Enable folding
"set foldcolumn=2             " Add a fold column
"set foldmethod=marker        " Detect triple-{ style fold markers
" Which commands trigger auto-unfold
"set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
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

" Search
set ignorecase                " Ignore case when searching
set smartcase                 " Ignore case if pattern is all lowercase, case-sensitive otherwise
set incsearch                 " Show search matches as you type
"set hlsearch                  " Highlight search terms. Use :nohls to remove highlighted search terms
set nohlsearch
set magic                     " Match literally for some characters in regular expression

" Use ,/ or \h to clear highlighted search terms
" :map \h :setlocal hlsearch!<CR>:set hlsearch?<CR>
:map <leader>/ :setlocal hlsearch!<CR>:set hlsearch?<CR>

" Hide buffers instead of closing them.
" This means that the current buffer can be put to background without being written and
" marks and undo history are preserved
set hidden
set switchbuf=useopen         " Reveal already opened files from the quickfix windows

" Don't backup file
set nobackup
set nowritebackup
set noswapfile

" ctags
" See https://github.com/majutsushi/tagbar/wiki
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }

" http://stackoverflow.com/questions/3881534/set-python-virtualenv-in-vim
" Function to activate a virtualenv in the embedded interpreter for
" omnicomplete and other things like that.
function LoadVirtualEnv(path)
    let activate_this = a:path . '/bin/activate_this.py'
    if getftype(a:path) == "dir" && filereadable(activate_this)
        python << EOF
import vim
activate_this = vim.eval('l:activate_this')
execfile(activate_this, dict(__file__=activate_this))
EOF
    endif
endfunction

" Load up a 'stable' virtualenv if one exists in ~/.virtualenv
let defaultvirtualenv = $HOME . "/.virtualenvs/stable"

" Only attempt to load this virtualenv if the defaultvirtualenv
" actually exists, and we aren't running with a virtualenv active.
if has("python")
    if empty($VIRTUAL_ENV) && getftype(defaultvirtualenv) == "dir"
        call LoadVirtualEnv(defaultvirtualenv)
    endif
endif

:so ~/.vimrc.local
