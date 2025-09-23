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
opt.guicursor = "n-v-c-i:block"
opt.confirm = true
opt.splitright = true
opt.splitbelow = true
opt.completeopt = "menuone,noselect"

-- folding
-- opt.foldcolumn = 'auto'
opt.foldmethod = 'syntax'

if vim.fn.has('macunix') then
	opt.shell = 'zsh'
else
	opt.shell = 'pwsh'
end

opt.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
opt.shellxquote = ''

opt.pumheight = 10
opt.shortmess = 'ltToOCFI'
opt.diffopt:append('iwhite')

-- For LSP config
vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = ' ',
			[vim.diagnostic.severity.WARN]  = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO]  = " "
		}
	},
	underline = true,
	update_in_insert = true,
	severity_sort = false,
})

opt.winborder = 'rounded'
opt.ls = 3
opt.fillchars = {
  horiz = '━',
  horizup = '┻',
  horizdown = '┳',
  vert = '┃',
  vertleft = '┫',
  vertright = '┣',
  verthoriz = '╋'
}
