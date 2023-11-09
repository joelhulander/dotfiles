return {
	{
		'nvim-telescope/telescope.nvim', 
		version = '*',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('telescope').setup{
				find_files = {
					path_display = 'truncate',
				},
				defaults = {
					layout_config = {
						vertical = { width = max },
					},
				},
			}
		end,
	} 
}
