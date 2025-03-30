local config = require("config").plugins

return {
	"nvim-treesitter/nvim-treesitter-context",
	enabled = config.treesitter_context ~= false,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local context = require("treesitter-context")

		context.setup({
			max_lines = 3,
		})
	end,
}
