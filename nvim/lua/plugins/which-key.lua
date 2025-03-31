local config = require("config").plugins

return {
	'folke/which-key.nvim',
	enabled = config.which_key ~= false,
	event = 'VeryLazy',
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
		require('which-key').setup()
	end
}
