"
" UI Related Settings
"
"===============================================================================

" Highlight the current line
set cursorline

" Flash when errors occur
set errorbells

"
set hlsearch

" Pattern searches should ignore case
set ignorecase

" Stop vim from writing backup files
set nobackup
set nowritebackup

" Write your swap files in this directory.
" But make sure it exists
set directory=$HOME/.vim/swp//

" Turn on line numbering
set number

" Update space for line numbers
set numberwidth=5

" Show the line and column number of the cursor position
set ruler

" Provides a couple of visual lines during conflict
set scrolloff=3

"
set shell=bash

"
set showcmd

" helps you find matching { and ( when you type ) } - if on screen
set showmatch

" Put a message in the status line for insert, replace, and visual modes
set showmode

" But be smart about it -- if I have any caps in my term, be case-sensitive.
set smartcase

" Flash when errors occur
set visualbell

"
" Indentation Settings
"---------------------------------------
"

" indent when moving to the next line while writing code
set smartindent

"
" Folding Settings
"---------------------------------------
"

set foldmarker={,} " This makes it work like other programming editors

set foldmethod=marker

set foldlevelstart=1


"
" Window Settings
"---------------------------------------
"

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright


"
" UI Improvements
"---------------------------------------
"


"
" Ideally, lines will be 80 characters or less
"
highlight IdealColumn ctermfg=White ctermbg=Yellow
call matchadd('IdealColumn', '\%81v.')

"
" 120 characters is the soft limit. It's up to you to keep your lines under 120
"
highlight SoftColumn ctermfg=White ctermbg=Red
call matchadd('SoftColumn', '\%121v.')



" custom status line, see :help 'statusline' for details
if has("statusline")
	set statusline=\<%n\>\ %f\ %m%r%h%w%=(%{&ff})\ line:%l\/%L\ (%p%%),\ col:%c\ \
endif


