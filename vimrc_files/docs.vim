"
" Opal Project
" VIM Editor Settings for Distraction Free Writing
" by Andrew Woods
" Updated 2015 Jun 16 Tue
"
"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
"
" Don't edit this file. Instead create .vimrc_scribe in your home directory
" and read this file with the following line
"
" :source ~/opal/vimrc_files/scribe
"
" If you want to change the value, copy the line from this file and change
" the value in your .vimrc_scribe This will allow you keep your changes after
" updates.
"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


source ~/opal/vimrc_files/vimrc 
source ~/opal/vimrc_files/_formatting.vim 
source ~/opal/vimrc_files/_ui-settings.vim 

"
" --------[ General VIM ]--------
"


set textwidth=72

" Don't try to highlight english prose 
syntax off

" Wrap lines without inserting characters in the content.  
set linebreak


" Do NOT indent when moving to the next line while writing code
set noautoindent
set nosmartindent

" Have only one space after a period.
set nojoinspaces

" visually wrap text to fit within the window 
set wrap


" Handles the settings for indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4


" When inserting a tab, expand it to spaces
set expandtab

" When searching for a term, the search will continue at the top of the file  
set wrapscan

" Auto-save
set autowriteall

" change the current working directory whenever you open a file,
set autochdir

