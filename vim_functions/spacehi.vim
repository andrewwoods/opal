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
" DisableSpaceHighlighting() respectively. You can also toggle the
" highlighting state by using ToggleSpaceHighlights(). By default,
" ToggleSpaceHi is bound to the key F3.
"
" You can customize the colors by setting the following variables to a string
" of key=val that would normally follow "highlight group" command:
"
"       g:spacehi_spacecolor
"       g:spacehi_tabcolor
"
" The defaults can be found in the "Default Global Vars" section below.
"
" You can give a list of filetypes to exclude
"
" If you want to highlight tabs and trailing spaces by default for every file
" that is syntax highlighted, you can add the following to your vimrc:
"
"       autocmd syntax * SpaceHi
"
" The author currently uses the following (a little overboard) in his vimrc:
"
"   autocmd BufNewFile,BufReadPost,FilterReadPost,FileReadPost,Syntax * SpaceHi
"   au FileType help NoSpaceHi

" Section: Plugin header
" If we have already loaded this file, don't load it again.
if exists("loaded_spacehi")
    finish
endif


let loaded_spacehi=1
let b:spacehi=0
let b:leadingSpacesHighlight=0
let b:trailingSpacesHighlight=0
let b:leadingTabsHighlight=0


"
" Section: Default Global Vars
"
if !exists("g:spacehi_tabcolor")
    " highlight tabs with red underline
    let b:spacehi_tabcolor="ctermfg=white ctermbg=green gui=underline"
    let b:spacehi_tabcolor=b:spacehi_tabcolor . " guifg=white  guibg=green "
endif


if !exists("b:spacehi_spacecolor")
    " highlight trailing spaces in blue or underline them
    let b:spacehi_spacecolor="ctermfg=white ctermbg=red"
    let b:spacehi_spacecolor=b:spacehi_spacecolor . " guifg=white guibg=red"
endif



"===============================================================================
"
"	Whitespace Highlighting Functions
"
"===============================================================================


"
" Turn ON highlighting for: Leading Tabs
"
function! HighlightLeadingTabs()
    syntax match spaceHighlightLeadingTabs /^\t\+/ containedin=ALL
    execute("highlight spaceHighlightLeadingTabs " . b:spacehi_tabcolor)

    let b:leadingTabsHighlight=1
endfunction

"
" Turn OFF highlighting for: Leading Tabs
"
function! DisableHighlightLeadingTabs()
    syntax clear spaceHighlightLeadingTabs

    let b:leadingTabsHighlight=0
endfunction


"
" Turn ON highlighting for: Leading Spaces
"
function! HighlightLeadingSpaces()
    syntax match spaceHighlightLeadingSpaces /^\ \+/ containedin=ALL
    execute("highlight spaceHighlightLeadingSpaces " . b:spacehi_spacecolor)

    let b:leadingSpacesHighlight=1
endfunction

"
" Turn OFF highlighting for: Leading Spaces
"
function! DisableHighlightLeadingSpaces()
    syntax clear spaceHighlightLeadingSpaces

    let b:leadingSpacessHighlight=0
endfunction


"
" Turn ON highlighting for: Trailing Spaces
"
function! HighlightTrailingSpaces()
    syntax match spaceHighlightTrailingSpaces /\s\+$/ containedin=ALL
    execute("highlight spaceHighlightTrailingSpaces " . b:spacehi_spacecolor)

    let b:trailingSpacesHighlight=1
endfunction

"
" Turn OFF highlighting for: Trailing Spaces
"
function! DisableHighlightTrailingSpaces()
    syntax clear spaceHighlightTrailingSpaces

    let b:trailingSpacesHighlight=0
endfunction


"
" Turn ON space highlighting flag
"
function! EnableSpaceHighlighting()
    let b:spacehi=1
endfunction

"
" Turn OFF space highlighting flag
"
function! DisableSpaceHighlighting()
    let b:spacehi=0
endfunction


" Toggle highlighting of whitespace
"
"   This should be defined in different vimrc files
"   to custom which whitespace characters should be highlighted
"
function! ToggleSpaceHighlights()
    if exists("b:spacehi") && b:spacehi
        :call TurnOffHighlights()
        echo "space highlighting: off"
    else
        :call TurnOnHighlights()
        echo "space highlighting: on"
    endif
endfunction


"===============================================================================
"
"	Example Functions - Copy these to your vimrc file
"
"===============================================================================

"
" Turn On Highlights
"
" Copy this function to your vimrc file and uncomment it
" Update the functions it calls, but not its function name
"
"
"function! TurnOnHighlights()
"	:call HighlightLeadingSpaces()
"	:call HighlightTrailingSpaces()
"
"    :call EnableSpaceHighlighting() " Keep this line
"endfunction

"
" Turn Off Highlights
"
" Copy this function to your vimrc file and uncomment it
" Update the functions it calls, but not its function name
"
"
"function! TurnOffHighlights()
"	:call DisableHighlightLeadingSpaces()
"	:call DisableHighlightTrailingSpaces()
"
"    :call DisableSpaceHighlighting() " Keep this line
"endfunction



"===============================================================================
"
"	Miscellaneious Functions
"
"===============================================================================


"
" Remove the whitespace at the end of every line
" and put the user back where they were
"
function! StripTrailingWhitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction


"===============================================================================
"
"	Function Key Mappings
"
"===============================================================================

" SEE THE INDIVIDUAL VIMRC FILES TO THE KEY MAPPINGS.
" THEY DON'T WORK WHEN THEY ARE KEPT HERE

