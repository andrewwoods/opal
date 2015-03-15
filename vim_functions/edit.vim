"
" Any files ending in .php will be syntax checked when saving
"
function CheckPhpSyntax()
   let current_file = shellescape(expand('%:p'))
   let command = '!php --syntax-check ' . current_file
   execute command
endfunction
autocmd BufWritePost,FileWritePost *.php call CheckPhpSyntax()

"
" @todo Figure out how to add the tab level to the current status line
"       without overwriting it entirely
"
" set statusline=\t%{ShowTab()}\ %P
"
function ShowTab()
	let TabLevel = (indent('.') / &ts )
	if TabLevel == 0
		let TabLevel='*'
	endif
	return TabLevel
endfunction

"
" Description:  Per buffer, togglable syntax highlighting of tabs and trailing
"               spaces.
" Author:       Adam Lazur <adam@lazur.org>
" Last Change:  $Date: 2002/10/11 20:37:13 $
" URL:          http://adam.lazur.org/vim/spacehi.vim
" License:      Redistribution and use of this file, with or without
"               modification, are permitted without restriction.
"
"
" This plugin will highlight tabs and trailing spaces on a line, with the
" ability to toggle the highlighting on and off. Using highlighting to
" illuminate these characters is preferrable to using listchars and set list
" because it allows you to copy from the vim window without getting shrapnel
" in your buffer.
"
" NOTE: "set list" will override SpaceHi's highlighting.
"
" Highlighting can be turned on and off with the functions SpaceHi() and
" NoSpaceHi() respectively. You can also toggle the highlighting state by
" using ToggleSpaceHi(). By default, ToggleSpaceHi is bound to the key F3.
"

if exists("loaded_spacehi")
    finish
endif
let loaded_spacehi=1

" Section: Default Global Vars
if !exists("g:spacehi_tabcolor")
    " highlight tabs with red underline
"    let g:spacehi_tabcolor="ctermfg=1 cterm=underline"
"    let g:spacehi_tabcolor=g:spacehi_tabcolor . " guifg=blue gui=underline"
endif
if !exists("g:spacehi_spacecolor")
    " highlight trailing spaces in blue underline
    let g:spacehi_spacecolor="ctermfg=white ctermbg=red "
    let g:spacehi_spacecolor=g:spacehi_spacecolor . " guifg=white guibg=red"
endif

"
" Turn on highlighting of spaces and tabs
"
function! s:SpaceHi()
    " highlight tabs
"    syntax match spacehiTab /\t/ containedin=ALL
"    execute("highlight spacehiTab " . g:spacehi_tabcolor)

    " highlight trailing spaces
    syntax match spacehiTrailingSpace /\s\+$/ containedin=ALL
    execute("highlight spacehiTrailingSpace " . g:spacehi_spacecolor)

    let b:spacehi = 1
endfunction

"
" Turn off highlighting of spaces and tabs
"
function! s:NoSpaceHi()
"    syntax clear spacehiTab
    syntax clear spacehiTrailingSpace
    let b:spacehi = 0
endfunction

" Function: s:ToggleSpaceHi()
" Toggle highlighting of spaces and tabs
function! s:ToggleSpaceHi()
    if exists("b:spacehi") && b:spacehi
        call s:NoSpaceHi()
        echo "spacehi off"
    else
        call s:SpaceHi()
        echo "spacehi on"
    endif
endfunction

" Section: Commands
com! SpaceHi call s:SpaceHi()
com! NoSpaceHi call s:NoSpaceHi()
com! ToggleSpaceHi call s:ToggleSpaceHi()

" Section: Default mappings
" Only insert a map to ToggleSpaceHi if they don't already have a map to
" the function and don't have something bound to F3
if !hasmapto('ToggleSpaceHi') && maparg("<F3>") == ""
  map <silent> <unique> <F3> :ToggleSpaceHi<CR>
endif
