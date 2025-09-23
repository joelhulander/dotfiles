local config = require("config").plugins

return {
	'SmiteshP/nvim-navic',
	enabled = config.nvim_navic ~= false,
	dependencies = {
		'neovim/nvim-lspconfig',
	},
}
