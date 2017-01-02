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
" DisableSpaceHighlighting() respectively. You can also toggle the highlighting state by
" using ToggleSpaceHighlights(). By default, ToggleSpaceHi is bound to the key F3.
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


" Section: Default Global Vars
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



"-------------------------------------------------------------------------------
"	Whitespace Highlighting Functions
"-------------------------------------------------------------------------------

"
" Turn on highlighting for: Leading Tabs
"
" b:spacehi_tabcolor
function! HighlightLeadingTabs()
    " highlight tabs
    syntax match spaceHighlightLeadingTabs /^\t\+/ containedin=ALL
    execute("highlight spaceHighlightLeadingTabs " . b:spacehi_tabcolor)

    let b:spacehi=1
    let b:leadingTabsHighlight=1
endfunction



"
" Turn on highlighting for: Leading Spaces
"
function! HighlightLeadingSpaces()
    syntax match spaceHighlightLeadingSpaces /^\ \+/ containedin=ALL
    execute("highlight spaceHighlightLeadingSpaces " . b:spacehi_spacecolor)

    let b:spacehi=1
    let b:leadingSpacesHighlight=1
endfunction



"
" Turn on highlighting for: Trailing Spaces
"
function! HighlightTrailingSpaces()
    " highlight trailing spaces
    syntax match spaceHighlightTrailingSpaces /\s\+$/ containedin=ALL
    execute("highlight spaceHighlightTrailingSpaces " . b:spacehi_spacecolor)

    let b:spacehi=1
    let b:trailingSpacesHighlight=1
endfunction



"
" Function: DisableSpaceHighlighting()
" Turn off highlighting of spaces and tabs
"
function! DisableSpaceHighlighting()
    syntax clear spaceHighlightLeadingSpaces
    syntax clear spaceHighlightTrailingSpaces
    syntax clear spaceHighlightLeadingTabs

    let b:spacehi=0
    let b:leadingSpacesHighlight=0
    let b:trailingSpacesHighlight=0
    let b:leadingTabsHighlight=0
endfunction



"
" Function: ToggleSpaceHighlights()
" Toggle highlighting of spaces and tabs
"
function! ToggleSpaceHighlights()
    if exists("b:spacehi") && b:spacehi
        call DisableSpaceHighlighting()
        echo "Disabled space highlighting"
    else
        call HighlightLeadingSpaces()
        call HighlightTrailingSpaces()
        call HighlightLeadingTabs()
        echo "Enabled space highlighting"
    endif
endfunction



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



" Section: Default mappings
" Only insert a map to ToggleSpaceHi if they don't already have a map to
" the function and don't have something bound to F3
if !hasmapto('ToggleSpaceHighlights') && maparg("<F3>") == ""
    map <silent> <unique> <F3> :call ToggleSpaceHighlights()<CR>
endif

