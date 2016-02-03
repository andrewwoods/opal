"
" Opal project
" VIM Editor Settings
" by Andrew Woods
" 2012 Mar 15 Thu
"
"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
"
" Don't edit this file. Instead create .vimrc in your home directory and read
" this file with the following line
"
" :source ~/opal/vimrc
"
" If you want to change the value, copy the line from this file and change the
" value in your .vimrc. This will allow you keep your changes after updates.
"
"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

:vmap <C-c> :s/^/\\\<\C\R\>/<CR>:nohlsearch<CR>
:vmap <C-A-c> :s/\\<CR[>]//<CR>:nohlsearch<CR>

source ~/opal/vim_functions/edit.vim


"
" GENERAL SETTINGS
"================================================================================
"

" Use VIM settings, rather than Vi
" This is set first because it changes other options as a side effect
set nocompatible

" Handles the settings for indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent smartindent

" Turn on line numbering
set number

" Display the filename
set ls=2

" Determine line endings
set fileformat=unix
set fileformats=unix,dos

" When inserting a tab, expand it to the appropriate number of spaces
set noexpandtab

" Search case-insensitively
set ignorecase

" But be smart about it -- if I have any caps in my term, be case-sensitive.
set smartcase

" Turn paste mode on/off using <F2>
set pastetoggle=<F2>

" Highlight the current line
set cursorline

" helps you find matching { and ( when you type ) }
set showmatch

" Flash when errors occur
set visualbell
set errorbells

" status bar settings
set ruler
set showmode

" miscellaneous settings
set shell=bash
set nobackup
set showcmd

set hlsearch


" Abbreviations
"================================================================================

"
" Different ways to write todays date
"
:iab <expr> now_date strftime("%Y %b %d %a")  " 2012 Mar 15 Thu
:iab <expr> now_datetime strftime("%Y %b %d %a %I:%M%p") " 2012 Mar 15 Thu 10:16PM
:iab <expr> epochtime strftime("%s") " 1331874188
:iab <expr> iso_date strftime("%Y-%m-%d") " 2012-03-15
:iab <expr> iso_datetime strftime("%Y-%m-%d %H:%M:%S") " 2012-03-15 22:03:23
:iab <expr> ukdate strftime("%d/%m/%Y") " 15/03/2012
:iab <expr> ukdate_text strftime("%d %B %Y") " 15 March 2012
:iab <expr> usdate strftime("%m/%d/%Y") " 03/15/2012
:iab <expr> usdate_text strftime("%B %d, %Y") " March 15, 2012
:iab <expr> time12 strftime("%I:%M:%S %p") " 10:20:00 PM
:iab <expr> time24 strftime("%H:%M:%S") " 22:20:06

:ab fold1 .!fold -s -w80
:ab foldall %!fold -s -w80

" Write a full php tag to prevent short tags
:ab <?= <?php echo ; ?>
:ab x_phpe <?php echo ; ?>hhhhha
:ab x_phpoc <?php  ?>hhhha
:ab x_php <?php
:ab x_package /*** description of package** @package YourPackage* @subpackage Subpackage name* @author firstname lastname <user@host.com>*/
:ab x_function /*** Describe your function** @param String $one a necessary parameter* @param String optional $two an optional value* @return void*/


" Common Mis-spellings
"
" https://en.wiktionary.org/wiki/Appendix:English_words_with_diacritics
"
:ab Liason Liaison
:ab Wordpress WordPress
:ab acceptible acceptable
:ab alot a lot
:ab anime animé
:ab aquit acquit
:ab attache attaché
:ab awhile a while
:ab basicly basically
:ab bcuz because
:ab becuase because
:ab cafe café
:ab cliche cliché
:ab communique communiqué
:ab continuum continuüm
:ab devt development
:ab divorceef divorcée
:ab divorceem divorcé
:ab eclair éclair
:ab entree entrée
:ab etude étude
:ab expose exposé
:ab facade façade
:ab fiance fiancé
:ab fiancee fiancée
:ab flambe flambé
:ab ios iOS
:ab ipad iPad
:ab iphone iPhone
:ab ipod iPod
:ab jalapeno jalapeño
:ab licence license
:ab lisence license
:ab mispell misspell
:ab naive naïve
:ab naivete naïveté
:ab noone no one
:ab nucular nuclear
:ab occurr occur
:ab privelege privilege
:ab priviledge privilege
:ab que queue
:ab repoire rapport
:ab resume résumé
:ab risque risqué
:ab saute sauté
:ab savy savvy
:ab seance séance
:ab senor señor
:ab senora señora
:ab senorita señorita
:ab soiree soirée
:ab souffle soufflé
:ab supposebly supposedly
:ab teh the
:ab threshhold threshold
:ab tommorrow tomorrow
:ab touche touché
:ab uber über
:ab useing using
:ab usualy usually
:ab vaccuum vacuum
:ab youre you're




"
:ab -80- --------------------------------------------------------------------------------
:ab =80= ================================================================================
:ab x80x xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
:ab *80* ********************************************************************************
:ab ~80~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
:ab :80: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:ab !80! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


"
" Lorem Ipsum text
"
:ab lorem_text Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
:ab lorem_list * Lorem ipsum dolor sit amet * consectetur adipisicing elit, sed do eiusmod * tempor incididunt ut labore et dolore magna aliqua.
:ab lorem_ul <ul><li>Lorem ipsum dolor sit amet</li><li>consectetur adipisicing elit, sed do eiusmod<li><li>tempor incididunt ut labore et dolore magna aliqua.</li></ul>

"
" INSERT the HTML vim file
"
:source ~/opal/vimrc_html

