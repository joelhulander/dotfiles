local config = require("config").plugins

return {
	"nvim-neotest/nvim-nio",
	enabled = config.nvim_nio ~= false,
	event = { "BufReadPre", "BufNewFile" }
}
