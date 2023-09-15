local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.expandtab = true

-- exrc
opt.exrc = true

-- line wrapping
opt.wrap = true
opt.textwidth = 100

-- list
opt.list = true
opt.listchars:append("trail:-")
opt.listchars:append("tab:  ")

-- path
opt.path = (".,**")

-- search settings
opt.ignorecase = false
opt.smartcase = true
opt.incsearch = true
opt.hls = true
opt.is = true

-- cursor
opt.cursorline = true
opt.guicursor = "i-ci-ve:block"

-- scrolloff
vim.opt.scrolloff = 4

-- sql filetype rebind
vim.cmd("let g:ftplugin_sql_omni_key = '<C-p>'")

-- appearance
opt.termguicolors = true
opt.signcolumn = "yes"
-- opt.colorcolumn = "80"

-- incremental substitute
opt.inccommand = "split"

-- split windows
opt.splitright = true
opt.splitbelow = true

-- update time
opt.updatetime = 50
--
-- swap & backup
opt.swapfile = false
opt.writebackup = false
vim.o.backupcopy = "yes"

-- short message
opt.shortmess:append("c")

-- mode
opt.showmode = true

-- backspace
opt.backspace = ""

-- global status line
opt.laststatus = 3

-- undo
opt.undofile = true
opt.undodir = vim.fn.stdpath("config") .. "/undo"

-- Command-line completion mode
opt.wildmode = "longest:full,full"

-- Minimum window width
opt.winminwidth = 5

-- popup menu
opt.pumheight = 8

-- Disable line wrap
opt.wrap = false

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1