" This rewires n and N to do the highlighing...
nnoremap <silent> n   n:call HLNext(0.6)<cr>
nnoremap <silent> N   N:call HLNext(0.6)<cr>

" highlight the match in magenta...
function! HLNext (blinktime)
    highlight WhiteOnDarkMagenta ctermfg=white ctermbg=DarkMagenta
	let [bufnum, lnum, col, off] = getpos('.')
	let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
	let target_pat = '\c\%#\%('.@/.'\)'
	let ring = matchadd('WhiteOnDarkMagenta', target_pat, 101)
	redraw
	exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
	call matchdelete(ring)
	redraw
endfunction

function! ListFunctions()
	exec 'grep function %'
endfunction

" com! ToggleSpaceHi call s:ToggleSpaceHi()

" map <silent> <unique> <F4> :ListFunctions<CR>

