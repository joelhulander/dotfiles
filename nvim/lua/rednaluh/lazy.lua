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

require('lazy').setup({{import = 'rednaluh.plugins'}, {import = 'rednaluh.plugins.lsp'}},{
	checker = { 
		enabled = true,
		notify = false,
	},
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
	change_detection = {
		notify = false,
	},
})
require('onedark').setup {
	style = 'darker'
}
require('onedark').load()

