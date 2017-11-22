

"=====================================
" My awesome PHP syntax checking stuff:
autocmd BufNewFile,BufRead,BufWritePost *.php,*.phtml execute 'call PHPsynCHK()'
set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l

function! HighlightBadPhp(...)
    if(exists('a:1'))
        let qflist=a:1
    else
        let qflist=getqflist()
    endif 
    let has_valid_error = 0
    for error in qflist
        if error['valid']
            let has_valid_error = 1
            break
        endif
    endfor
    if has_valid_error
        let linecontent=getline(error.lnum)
        if error.text =~ 'unexpected \$end$'
            let linenum=FindNextNonBlankLine(error.lnum, "up")
        elseif error.text =~ 'unexpected T_FUNCTION' && linecontent =~ '^\s*function\s.*'
            let linenum=FindNextNonBlankLine(error.lnum, "up")
        elseif error.text =~ 'unexpected T_CLASS' && linecontent =~ '^\s*class\s.*'
            let linenum=FindNextNonBlankLine(error.lnum, "up")
        elseif error.text =~ 'unexpected T_VARIABLE' && linecontent =~ '^\s*\$[A-Za-z].*'
            let linenum=FindNextNonBlankLine(error.lnum, "up")
        elseif error.text =~ 'unexpected .}.' && linecontent =~ '^\s*}.*'
            let linenum=FindNextNonBlankLine(error.lnum, "up")
        else
            let linenum=error.lnum
        endif
        silent execute 'match SpellBad /\%'.linenum.'l\V\^'.escape(getline(linenum), '\').'\$/'
        call cursor(linenum, col('.'))
    else
        " No errors found, clear highlighting
        execute 'match'
    endif
endfunction

function! FindNextNonBlankLine(startLine, direction)
    let matchLine=a:startLine
    if a:direction == 'up'
        let lines=sort(range(1, a:startLine-1), "ReverseSort")
    else
        let lines=range(a:startLine+1, line("$"))
    endif
    for line in lines
        let linecontent=getline(line)
        if linecontent !~ '^\s*$'
            let matchLine=line
            break
        endif
    endfor
    return matchLine
endfunction

function! ReverseSort(i1, i2)
    return a:i2 - a:i1
endfunction

function! PHPsynCHK()
    ccl " close quickfix window
    let winnum = winnr() " get current window number
    let tmpfile = tempname()
    " good luck if you have Windows
    silent execute "!php -l ".shellescape(bufname("%"))." 2>&1 | grep 'Parse error' > ".tmpfile
    silent execute "cg ".tmpfile
    let qflist=getqflist()
    if 0 < len(qflist)
        cope 2 " open the quickfix window
        silent execute "wincmd J"
        silent execute winnum . "wincmd w"
        call HighlightBadPhp(qflist)
    else
        execute 'match'
    endif
endfunction

noremap <leader>l :execute 'call PHPsynCHK()'<CR>



