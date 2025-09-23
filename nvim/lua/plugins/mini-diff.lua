local config = require("config").plugins

return {
	'echasnovski/mini.diff',
	version = false,
	enabled = config.mini_diff ~= false,
	config = function()
		require('mini.diff').setup(
			{
				view = {
					style = 'sign',
				},
				mappings = {
					apply = '<leader>ga',
					reset = '<leader>gr',

					textobject = '<leader>gh',

					goto_first = '<leader>[H',
					goto_prev = '<leader>[h',
					goto_next = '<leader>]h',
					goto_last = '<leader>]H',
				},
			}
		);
	end
}

