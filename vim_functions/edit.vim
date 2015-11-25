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


"-------------------------------------------------------------------------------
"	Whitespace Highlighting Functions
"-------------------------------------------------------------------------------

"
" Turn on highlighting for: Leading Tabs
"
function! LeadingTabHi()
    " highlight tabs
    syntax match spacehiLeadingTab /^\t\+/ containedin=ALL
    execute("highlight spacehiLeadingTab ctermfg=white ctermbg=red ")

    let b:leadingTabHi = 1
endfunction

"
" Turn on highlighting for: Leading Spaces
"
function! LeadingSpacesHi()
    " highlight tabs
    syntax match spacehiLeadingSpace /^\ \+/ containedin=ALL
    execute("highlight spacehiLeadingSpace ctermfg=white ctermbg=red ")

    let b:leadingSpaceHi = 1
endfunction


"
" Turn on highlighting for: Trailing Spaces
"
function! TrailingSpaceHi()
    " highlight trailing spaces
    syntax match spacehiTrailingSpace /\s\+$/ containedin=ALL
    execute("highlight spacehiTrailingSpace ctermfg=white ctermbg=red ")

    let b:trailingSpaceHi = 1
endfunction


