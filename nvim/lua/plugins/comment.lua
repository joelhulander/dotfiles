local config = require("config").plugins

return {
    'numToStr/Comment.nvim',
	enabled = config.comment ~= false,
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		require('Comment').setup {}
	end,
}
