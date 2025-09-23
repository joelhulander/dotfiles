local config = require("config").plugins

return {
	"obsidian-nvim/obsidian.nvim",
	enabled = config.obsidian ~= false,
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = vim.g.personal_settings.obsidian.workspaces,
		daily_notes = vim.g.personal_settings.obsidian.daily_notes,
		templates = {
			folder = vim.g.personal_settings.obsidian.templates.folder,
			date_format = vim.g.personal_settings.obsidian.templates.date_format,
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

			if spec.title and spec.title:match("Note (template)") then
				path = spec.dir / "6 - Notes" / tostring(spec.title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower())
			elseif spec.title and spec.title:match("Meeting") then
				local year = os.date("%Y")
				local month = os.date("%m-%B")
				path = spec.dir / "6 - Notes" / "Meetings" / year / month / tostring(spec.title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower())
			else
				-- Default behavior for other templates
				path = spec.dir / tostring(spec.title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower())
			end
			return path:with_suffix ".md"
		end,
		follow_url_func = function(url)
			vim.ui.open(url)
		end,
		preferred_link_style = "markdown",
		disable_frontmatter = false,
		completion = {
			blink = true,
			min_chars = 2,
			create_new = true
		},
		legacy_commands = false,
		ui = {
			enable = false
		}
	},
}
