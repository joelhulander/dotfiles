return {
	"nvim-treesitter/nvim-treesitter-context",
	enabled = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local context = require("treesitter-context")

		context.setup({
			max_lines = 3,
		})
	end,
}
