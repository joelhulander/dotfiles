local config = require("config").plugins

return {
	'norcalli/nvim-colorizer.lua',
	enabled = config.colorizer ~= false,
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		require('colorizer').setup {}
	end,
}
