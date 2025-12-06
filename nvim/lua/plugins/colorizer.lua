return {
	'norcalli/nvim-colorizer.lua',
	enabled = false,
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		require('colorizer').setup {}
	end,
}

