

" Determine line endings
set fileformat=unix
set fileformats=unix,dos

"
set listchars=""
set listchars+=tab:§¬
set listchars+=eol:¶
set listchars+=trail:¤
set listchars+=extends:»
set listchars+=precedes:«


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


