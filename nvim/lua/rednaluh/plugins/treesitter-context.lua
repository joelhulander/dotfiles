return {
	"nvim-treesitter/nvim-treesitter-context",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local context = require("treesitter-context")

		context.setup({
			max_lines = 3,
		})
	end,
}
