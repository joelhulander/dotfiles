return {
	'norcalli/nvim-colorizer.lua',
	enabled = true,
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		require('colorizer').setup {}
	end,
}
