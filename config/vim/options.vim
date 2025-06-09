" --[[
"
" Base Options File
"
" These options assume you are writing code.
"
" See `:help vim.opt`
" see `:help option-list`
"
" NOTE: Require this file for getting started quickly. You may want to copy this
" to your dotfiles, so you can make local modifications.
"
" --]]

set exrc
set guicursor=""

set nu
set relativenumber
set numberwidth=6

set mouse="a"

set splitbelow
set splitright

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set breakindent
set smartindent

set nowrap

set nojoinspaces
set textwidth=0
set wrapmargin=0
set linebreak

set noswapfile
set nobackup
set undofile

set hlsearch
set incsearch
set wrapscan
set ignorecase
set smartcase

" FIXME: The inccommand option seems to be not available in Vim.
" Neovim only? or different name?
" set inccommand="split"
set sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

set termguicolors
set noshowmode

set scrolloff=8
set sidescroll=12
set sidescrolloff=12

set signcolumn="yes"
" FIXME: what should this be in Vim?
"set isfname:append("@-@")

set timeoutlen=300
set updatetime=250

set nolist
set listchars=""
set listchars+=tab:>¬
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=trail:∙
set listchars+=nbsp:␣
set listchars+=eol:¶

set cursorline

set fileformat=unix
set fileformats=unix,dos
set formatoptions=tcq

