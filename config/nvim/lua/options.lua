--[[

Base Options File

These options assume you are writing code.

See `:help vim.opt`
see `:help option-list`

NOTE: Require this file for getting started quickly. You may want to copy this
to your dotfiles, so you can make local modifications.

--]]

vim.opt.exrc = true
vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 6

vim.opt.mouse = "a"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.breakindent = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.joinspaces = false
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.opt.linebreak = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.wrapscan = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.inccommand = "split"
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.opt.termguicolors = true
vim.opt.showmode = false

vim.opt.scrolloff = 8
vim.opt.sidescroll = 12
vim.opt.sidescrolloff = 12

vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.timeoutlen = 300
vim.opt.updatetime = 250

vim.opt.list = false
vim.opt.listchars = {
    tab = ">¬",
    extends = "»",
    precedes = "«",
    trail = "·",
    nbsp = "␣",
    eol = "¶",
}

vim.opt.cursorline = true

vim.opt.fileformat = "unix"
vim.opt.fileformats = "unix,dos"
vim.opt.formatoptions = "tcq"
