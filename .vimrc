" File: .vimrc
" Version: 1.0
" Author: Junjie Tang
" Created: 25 Dec 2013 23:49:19
" Vim: revisited By Mislav Marohnic on 12 Dec 2011
" Last-modified: 10 Jan 2014 9:57:13 AM

"" Vim package manager
execute pathogen#infect()
syntax on
filetype plugin indent on       " load file type plugins + indentation

"" Load my color scheme
set t_Co=256
colorscheme jellybeans

"" Disable cursor blinking
let &guicursor = substitute(&guicursor, 'n-v-c:', '&blinkon0-', '')

"" Sane default
set nocompatible                " choose no compatibility with legacy vi
set encoding=utf-8              " utf-8 for most flavors of Unicode
set shortmess=I                 " disable the Vim welcome screen
set modelines=0
set scrolloff=3                 " have some context around the current line always on screen
set autoindent
set autoread                    " auto-reload buffers when file changed on disk
set showmode
set showcmd                     " display incomplete commands
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline                  " hightlight the line of the cursor
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set number
set relativenumber
set clipboard+=unnamed          " share windows clipboard
set tabpagemax=100
set nobackup                    " trun off backup file
set nowritebackup
set listchars=tab:▸\ ,eol:¬     " show invisible characters with the same characters that TextMate uses
au FocusLost * :wa              " save on losing focus

"" Whitespace
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set softtabstop=2
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set gdefault                    " applies substitutions globally on lines
set hlsearch                    " highlight matches
set showmatch
set incsearch                   " incremental searching

"" Chinese environment
"set guifont=Consolas:h12
"set guifontwide=NSimsun:h12
"set langmenu=zh_CN.UTF-8
"source $VIMRUNTIME/delmenu.vim
"source $VIMRUNTIME/menu.vim
"language messages zh_CN.UTF-8
if has("win32")
  set guifont=Consolas:h11
  set guifontwide=NSimsun:h11
  set termencoding=cp936
  cd $USERPROFILE\Desktop         " default working directory
endif
"set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
"set fileencoding=utf-8

"" GUI options
if has('gui_running')
  " Set the gui options to:
  "   g: grey inactive menu items
  "   m: display menu bar
  "   r: display scrollbar on right side of window
  "   b: display scrollbar at bottom of window
  "   t: enable tearoff menus on Win32
  "   T: enable toolbar on Win32
  set go=gmt
  set nowrap                      " don't wrap lines
  set textwidth=79                " line character width
  set lines=37                    " Set number of lines for the display
  set cmdheight=2                 " 2 for the status line.
  set columns=79                  " add columns for the Project plugin
  set formatoptions=qrn1
  set colorcolumn=85
  set mouse=a                     " enable use of mouse
  let html_use_css=1              " for the TOhtml command
endif

" ************************************************************************
" B E G I N  A U T O C O M M A N D S
" ************************************************************************

if has("autocmd")

  " when editing a file, always jump to Master Product IDthe last known cursor position.
  " don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " add an autocommand to update an existing time stamp when writing the file
  " It uses the functions above to replace the time stamp and restores cursor
  " position afterwards (this is from the FAQ)
  autocmd BufWritePre,FileWritePre *   ks|call UpdateTimeStamp()|'s

  " change _vimrc with auto reload
  autocmd! bufwritepost .vimrc source ~\.vimrc

endif

" ************************************************************************
" K E Y   M A P P I N G S
" ************************************************************************

" use comma as <Leader> key instead of backslash
let mapleader=","

" turns off Vim’s crazy default regex characters
nnoremap / /\v
vnoremap / /\v

nnoremap <leader><space> :noh<CR>
nnoremap <tab> %
vnoremap <tab> %

" leader key mappings
nmap <leader>l :set list!<CR>
nnoremap <silent><leader>c :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR><Bar>:retab<CR>
nnoremap <leader>a :Ack
nnoremap <leader>ft Vatzf     " fold tag while work with HTML
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
nnoremap <leader>q gqip       " re-hardwrap paragraphs of text
nnoremap <leader>v V`]        " reselect the text that was just pasted
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>
nnoremap <leader><tab> :Sscratch<CR>

" quicker escaping
inoremap jj <ESC>

" disable the arrow keys while you’re in normal mode
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" quickly alternate between opened buffers
nnoremap <leader><leader> <c-^>

" easier navigation between split windows
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <leader>w <C-w>v<C-w>l

" pressing < or > will let you indent/unident selected lines
vnoremap < <gv
vnoremap > >gv

" make tab in v mode work like I think it should (keep highlighting):
vmap <tab> >gv
vmap <s-tab> <gv

" map <c-s> to write current buffer.
map <c-s> :w<cr>
imap <c-s> <c-o><c-s>
imap <c-s> <esc><c-s>

" select all.
map <c-a> ggVG

" assign ctrl+c to copy to clipboard in visual mode
vmap <c-c> "+y

" assign ctrl+v to paste from clipboard in normal and insert modes
nmap <c-v> "+gP
imap <c-v> <esc>"+pA

" undo in insert mode.
imap <c-z> <c-o>

" ************************************************************************
"  F U N C T I O N S
" ************************************************************************

" first add a function that returns a time stamp in the desired format
if !exists("*TimeStamp")
  fun TimeStamp()
    return "Last-modified: " . strftime("%d %b %Y %X")
  endfun
endif

" searches the first ten lines for the timestamp and updates using the
" TimeStamp function
if !exists("*UpdateTimeStamp")
  function! UpdateTimeStamp()
    " Do the updation only if the current buffer is modified
    if &modified == 1
      " go to the first line
      exec "1"
      " Search for Last modified:
      let modified_line_no = search("Last-modified:")
      if modified_line_no != 0 && modified_line_no < 10
        " There is a match in first 10 lines
        " Go to the : in modified:
        exe "s/Last-modified: .*/" . TimeStamp()
      endif
    endif
  endfunction
endif
