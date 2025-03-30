local config = require("config").plugins

return {
	'akinsho/toggleterm.nvim',
	enabled = config.toggleterm ~= false,
	version = "*",
	opts = {
		shade_terminals = false,
		direction = 'float'
	},
	config = function(_, opts)
		local toggleterm = require("toggleterm")

		toggleterm.setup(opts)

		local terminal  = require('toggleterm.terminal').Terminal
		local lazygit = terminal:new({ cmd = "lazygit", hidden = true })

		local keymap = vim.keymap

		function lazygit_toggle()
			lazygit:toggle()
		end

		keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal', noremap = true, silent = true})
		keymap.set('n', '<leader>tl', '<cmd>lua lazygit_toggle()<CR>', { desc = 'Open lazygit', noremap = true, silent = true })
	end,
}

