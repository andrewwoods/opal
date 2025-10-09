
let mapleader = " "
let maplocalleader = "-"

" Paste from the System clipboard
nnoremap <leader>v "+p

" Toggle the [F]ile [E]xplorer
nnoremap <leader>pv :Lexplore!<cr>

" Search the Help for a string
nnoremap <leader>? :help <cword><cr>

" Search for a string in the project
" WARNING: This hangs my vim session!
"nnoremap <leader>/ :vimgrep <cword> **<cr>

" Source the current file
nnoremap <leader>so :so %<cr>


" [D]isplay [K]eymaps
nnoremap <leader>dk :map<cr>

" [W]ord [C]ount
nnoremap <Leader>wc g<C-g>

"
" Quick Fix List
" --------------
"

" [Q]uickfix List [O]pen
nnoremap <leader>qo :copen<cr>

" [Q]uickfix List Close/[Q]uit
nnoremap <leader>qq :cclose<cr>

" [Q]uickfix List [N]ext
nnoremap <leader>qn :cnext<cr>

" [Q]uickfix List [P]rev
nnoremap <leader>qp :cprev<cr>

"
" Window Movement Commands
" ------------------------
"
nnoremap <leader>wh :wincmd h<cr>
nnoremap <leader>wl :wincmd l<cr>
nnoremap <leader>wj :wincmd j<cr>
nnoremap <leader>wk :wincmd k<cr>
nnoremap <leader>wv :vsp<cr>
nnoremap <leader>w- :sp<cr>
nnoremap <leader>fv :vsp <cfile><cr>
nnoremap <leader>f- :sp <cfile><cr>

"
" Keep the search results centered
" --------------------------------
"

" Go to next search result"
nnoremap n nzzzv

" Go to prev search result
nnoremap N Nzzzv

"
" Yanks text into the System Clipboard
"
nnoremap <leader>y [["+y]]
nnoremap <leader>Y [["+Y]]


" Delete text using the Black Hole Register
nnoremap <leader>d [["_d]]

"-- No Op > Do nothing
nnoremap Q <nop>

"-- Move visually selected lines up and down

" Move selected lines down
vnoremap J :m '>+1<CR>gv=gv

" Move selected lines up
vnoremap K :m '<-2<CR>gv=gv

