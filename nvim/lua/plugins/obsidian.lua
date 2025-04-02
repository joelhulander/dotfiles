local config = require("config").plugins

return {
	"obsidian-nvim/obsidian.nvim",
	enabled = config.obsidian ~= false,
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	lazy = true,
	ft = "markdown",
	opts = {
		workspaces = {
			{
				name = "work",
				path = "~/OneDrive - Sweet Systems AB/Documents/Work",
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
				end,
				date_title = function()
					local day = tonumber(os.date("%d"))
					local suffix

					if day >= 11 and day <= 13 then
						suffix = "th"
					else
						local last_digit = day % 10
						if last_digit == 1 then
							suffix = "st"
						elseif last_digit == 2 then
							suffix = "nd"
						elseif last_digit == 3 then
							suffix = "rd"
						else
							suffix = "th"
						end
					end

					return os.date("%A, %B ") .. day .. suffix .. os.date(", %Y")
				end,
				company = function()
					return vim.fn.input("Which company: ")
				end
			}
		},
		note_path_func = function(spec)
			local path
			if spec.title:match("Note (template)") then
				path = spec.dir / "6 - Notes" / tostring(spec.title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower())
			elseif spec.title:match("Meeting") then
				local year = os.date("%Y")
				local month = os.date("%m-%B")
				path = spec.dir / "6 - Notes" / "Meetings" / year / month / tostring(spec.title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower())
			else
				-- Default behavior for other templates
				path = spec.dir / tostring(spec.title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower())
			end
			return path:with_suffix(".md")
		end,
		preferred_link_style = "markdown",
		disable_frontmatter = false,
		mappings = {
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			["<leader>ox"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { desc = "Toggle checkbox", buffer = true },
			},
		},
		ui = {
			enable = false
		}
	},
}
