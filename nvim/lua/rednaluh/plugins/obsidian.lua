return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	event = {
		"BufReadPre C:/Users/JoelHulander/obsidian/*.md",
	},
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
			folder = "Daily Notes",
			date_format = "%Y-%m-%d-%A",
			-- Make the note_id_func return the full path structure
			note_id_func = function(date)
				local year = os.date("%Y", date)
				local month_num = os.date("%m", date)
				local month_name = os.date("%B", date)
				local filename = os.date("%Y-%m-%d-%A", date)

				return string.format("%s/%s-%s/%s",
					year,           -- YYYY
					month_num,      -- MM
					month_name,     -- MMMM
					filename        -- YYYY-MM-DD-dddd
				)
			end,
			default_tags = { "daily-notes" },
			template = "Templates/Daily Note Template"
		},
		templates = {
			folder = "Templates"
		},
		preferred_link_style = "markdown",
		disable_frontmatter = true,
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
