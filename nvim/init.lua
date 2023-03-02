require('config')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'--single-branch',
		'https://github.com/folke/lazy.nvim.git',
		lazypath,
	})
end

vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup('plugins', {
	checker = { enabled= true },
	performance = {
		rtp = {
			disabled_plugins = {
				'gzip',
				'matchit',
				'matchparen',
				'netrwPlugin',
				'tarPlugin',
				'tohtml',
				'tutor',
				'zipPlugin',
			},
		},
	},
})
--vim.cmd.colorscheme('onedark')
require('onedark').setup {
	style = 'darker'
}
require('onedark').load()

require('lualine').setup() 
require('nvim-treesitter').setup() 
require('nvim-tree').setup()
require('telescope').setup()
require('indent_blankline').setup()
