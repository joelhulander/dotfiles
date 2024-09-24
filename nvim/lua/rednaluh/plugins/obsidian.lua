return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "notes",
				path = "~/obsidian",
			}
		},
		daily_notes = {
			folder = "Daily notes",
			date_format = "%Y-%m-%d",
			alias_format = "%B %-d, %Y",
			default_tags = { "daily-notes" },
			template = nil
		},
		preferred_link_style = "wiki",
		mappings = {
			-- Toggle check-boxes.
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
			["<leader>nn"] = {
				action = function()
					return require("obsidian").new()
				end,
				opts = { buffer = true },
			},
		},
	},
}
