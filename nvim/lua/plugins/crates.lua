local config = require("config").plugins

return {
	"Saecki/crates.nvim",
	event = { "BufRead Cargo.toml" },
	enabled = config.crates ~= false,
	opts = {
		completion = {
			crates = {
				enabled = true,
			},
		},
		lsp = {
			enabled = true,
			actions = true,
			completion = true,
			hover = true,
		},
	},
}
