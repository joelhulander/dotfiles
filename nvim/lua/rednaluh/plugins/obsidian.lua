return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	event = {
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "work",
			}
		},
		daily_notes = {
			folder = "1 - Daily Notes",
			date_format = "%Y/%m-%B/%Y-%m-%d-%A",
			default_tags = { "daily-note" },
			template = "5 - Templates/Daily (template)"
		},
		templates = {
			folder = "5 - Templates",
			date_format = "%Y/%m-%B/%Y-%m-%d-%A",
			substitutions = {
				year = function()
					return os.date("%Y", nil)
				end,
				month = function()
					return os.date("%m", nil)
				end,
				monthName = function()
					return os.date("%B", nil)
				end,
				day = function()
					return os.date("%d", nil)
				end,
				weekday = function()
					return os.date("%A", nil)
				end,
				dateUID = function()
					return os.date("%Y%m%d%H%M")
				end,
				customDate = function()
					return os.date("%Y-%m-%d")
				end
			}
		},
		preferred_link_style = "markdown",
		disable_frontmatter = false,
		mappings = {
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
		},
		ui = {
			enable = false
		}
	},
}
