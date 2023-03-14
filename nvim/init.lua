require('core')

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
-- vim.g.OmniSharp_translate_cygwin_wsl = 1
-- vim.g.OmniSharp_highlighting = 0


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
require('onedark').setup {
	style = 'darker'
}
require('onedark').load()

