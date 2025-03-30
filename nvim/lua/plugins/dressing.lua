local config = require("config").plugins

return {
	"stevearc/dressing.nvim",
	enabled = config.dressing ~= false,
	event = "VeryLazy",
}
