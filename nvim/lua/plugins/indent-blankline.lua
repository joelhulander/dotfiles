local config = require("config").plugins

return {
	'lukas-reineke/indent-blankline.nvim',
	enabled = config.indent_blankline ~= false,
	main = "ibl",
	opts = {},
}
