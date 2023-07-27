
" Handles the settings for indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4

" When inserting a tab, expand it to the appropriate number of spaces
set expandtab



" Determine line endings
set fileformat=unix
set fileformats=unix,dos

"
set listchars=""
set listchars+=tab:§¬
set listchars+=eol:¶
set listchars+=trail:∙
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=nbsp:¤

" This affects the auto-formatting of text and code.
" THis disables auto formatting

set formatoptions=tcq

"

"autocmd FileType * setlocal formatoptions-=t formatoptions-=c

" Fold one line so it fits within 80 characters
:ab fold1 .!fold -s -w80

" Fold every line of the file so they fit within 80 characters
:ab foldall %!fold -s -w80


"
:ab -80- --------------------------------------------------------------------------------
:ab =80= ================================================================================
:ab x80x xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
:ab *80* ********************************************************************************
:ab ~80~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
:ab :80: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:ab !80! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


