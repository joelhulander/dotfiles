local config = require("config").plugins

return {
	"folke/snacks.nvim",
	enabled = config.snacks ~= false,
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		picker = {},
		input = {},
		lazygit = {}
	}
}
