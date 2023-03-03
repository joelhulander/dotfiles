return {
	{
		'nvim-telescope/telescope.nvim', 
		version = '*',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('telescope').setup{}
		end,
	} 
}
