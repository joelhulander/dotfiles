local config = require("config").plugins

return {
	'windwp/nvim-autopairs',
	enabled = config.autopairs ~= false,
	event = "InsertEnter",
	opts = {} -- this is equalent to setup({}) function
}
