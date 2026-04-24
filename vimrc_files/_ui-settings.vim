"
" UI Related Settings
"
"===============================================================================

" Highlight the current line

" Flash when errors occur
set errorbells

" Pattern searches should ignore case

" Stop vim from writing backup files
set nowritebackup

" Write your swap files in this directory.
" But make sure it exists
set directory=$HOME/.vim/swp/

" Show the line and column number of the cursor position
set ruler
"
set shell=bash

"
set showcmd
set showmatch

" Flash when errors occur
set visualbell

" indent when moving to the next line while writing code
set smartindent

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


