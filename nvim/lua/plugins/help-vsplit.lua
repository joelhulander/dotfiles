local config = require("config").plugins

return {
	'anuvyklack/help-vsplit.nvim',
	enabled = config.help_vsplit ~= false,
	config = function()
		require('help-vsplit').setup()
	end
}
