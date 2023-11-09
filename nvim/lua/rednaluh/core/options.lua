local opt = vim.opt

-- line numbers
opt.number = true
opt.relativenumber = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = false

-- line wrapping
opt.wrap = false

--search settings
opt.ignorecase = true
opt.smartcase = true

-- turn off swapfile
opt.swapfile = false

-- other settings
opt.mouse = 'a'
opt.hlsearch = false
opt.wrap = false
opt.termguicolors = true
opt.smartindent = true
opt.cursorline = true
opt.confirm = true
opt.clipboard = "unnamedplus"
opt.completeopt = 'menuone,noselect'
opt.shell = "pwsh"
