return {
	'echasnovski/mini.nvim', version = false,
	config = function()
		require('mini.diff').setup(
			{
				view = {
					style = 'sign',
				},
				mappings = {
					apply = '<leader>gh',
					reset = '<leader>gH',

					textobject = '<leader>gh',

					goto_first = '<leader>[H',
					goto_prev = '<leader>[h',
					goto_next = '<leader>]h',
					goto_last = '<leader>]H',
				},
			}
		);
		require('mini.git').setup(
			{
				command = {
					split = 'vertical'
				}
			}
		);
		require('mini.pick').setup()
	end
}

