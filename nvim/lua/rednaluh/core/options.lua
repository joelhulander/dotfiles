local opt = vim.opt

-- line numbers
opt.number = true
opt.relativenumber = true

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false

-- line wrapping
opt.wrap = false

--search settings
opt.ignorecase = true
opt.smartcase = true

-- turn off swapfile
opt.swapfile = false

-- other settings
opt.mouse = "a"
opt.hlsearch = true
opt.wrap = false
opt.scrolloff = 10
opt.termguicolors = true
opt.smartindent = true
opt.cursorline = true
opt.confirm = true
opt.clipboard = "unnamedplus"
opt.completeopt = "menuone,noselect"

opt.shell = "pwsh"
opt.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
opt.shellxquote = ''

opt.pumheight = 10
opt.shortmess = {
	I = true,
}
opt.diffopt:append('iwhite')
