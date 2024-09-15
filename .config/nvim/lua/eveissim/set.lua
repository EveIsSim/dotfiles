vim.opt.guicursor = ""
vim.cmd [[
    syntax enable
]]

--=================================================

--INDENT
-- Set tab width to 4 columns.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.scrolloff = 8

vim.opt.colorcolumn = "100"
vim.opt.updatetime = 50

--=================================================

-- Add numbers to each line on the left-hand side.
vim.opt.nu = true
vim.opt.relativenumber = true

--=================================================
-- Always show sign column
vim.opt.signcolumn = "yes"
vim.opt.foldmethod = "manual"

-- Use system register/buffer saving copy/paste text
vim.opt.clipboard = "unnamedplus"

--=================================================

--SEARCH
-- While searching though a file incrementally highlight matching characters as you type.
vim.opt.incsearch = true

-- Use highlighting when doing a search.
vim.opt.hlsearch = true


vim.opt.termguicolors = true
vim.opt.isfname:append("@-@")


vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true


--WILDMENU
-- Enable auto completion menu after pressing TAB.
vim.opt.wildmenu = true
-- Make wildmenu behave like similar to Bash completion.
-- set wildmode=list:longest
-- There are certain files that we would never want to edit with Vim.
-- Wildmenu will ignore files with these extensions.
-- set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
--

--FILETYPE
-- Enable type file detection. Vim will be able to try to detect the type of file in use. filetype on
-- Enable plugins and load plugin for the detected file type.
-- Load an indent file for the detected file type.
vim.api.nvim_command('filetype plugin indent on')


