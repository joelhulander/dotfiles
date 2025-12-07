local opt = vim.opt

-- Basic settings
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 10
opt.sidescrolloff = 8

-- Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.autoindent = true
opt.expandtab = true

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Visual settings
opt.termguicolors = true
opt.signcolumn = "yes"
opt.showmatch = true
opt.matchtime = 2
opt.pumheight = 10
opt.pumblend = 10
opt.winblend = 0
opt.completeopt = "menuone,noinsert,noselect"
opt.concealcursor = ""
opt.lazyredraw = true
opt.synmaxcol = 300

-- File handling
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.updatetime = 300
opt.timeoutlen = 500
opt.ttimeoutlen = 0
opt.autoread = true
opt.autowrite = false

-- Behaviour settings
opt.iskeyword:append("-")
opt.selection = "exclusive"
opt.mouse = "a"
opt.encoding = "UTF-8"

-- Cursor settings
opt.guicursor = "n-v-c:block,i-ci-ve:block"

-- Split behaviour
opt.splitright = true
opt.splitbelow = true

-- folding
-- opt.foldcolumn = 'auto'
opt.foldmethod = 'expr'
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99

if vim.fn.has('macunix') then
	opt.shell = 'zsh'
else
	opt.shell = 'pwsh'
end

-- opt.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
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

-- Performance improvements
opt.redrawtime = 10000
opt.maxmempattern = 20000
