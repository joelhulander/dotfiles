return {
	"obsidian-nvim/obsidian.nvim",
	enabled = vim.g.personal_settings.obsidian or false,
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = function()
		local settings = vim.g.personal_settings.obsidian

		return {
			workspaces = settings.workspaces,
			daily_notes = settings.daily_notes,
			templates = {
				folder = settings.templates.folder,
				date_format = settings.templates.date_format,
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
				local notes_folder = settings.notes_folder or "Notes"
				local function slugify(str)
					return tostring(str:gsub(" ", "-").gsub("[^A-Za-z0-9-]", ""):lower())
				end

				local path

				if spec.id then
					path = spec.dir / (spec.id .. ".md")
				elseif spec.title and spec.title:match("Note (nvim)") then
					path = spec.dir / notes_folder / slugify(spec.title)
				elseif spec.title and spec.title:match("Meeting") then
					local year = os.date("%Y")
					local month = os.date("%m-%B")
					path = spec.dir / notes_folder / "Meetings" / year / month / slugify(spec.title)
				else
					-- Default behavior for other titles
					path = spec.dir / os.date("%Y-%m-%d-%H%M")
				end
				return path:with_suffix ".md"
			end,
			follow_url_func = function(url)
				vim.ui.open(url)
			end,
			preferred_link_style = "markdown",
			completion = {
				blink = true,
				min_chars = 2,
				create_new = true
			},
			legacy_commands = false,
			ui = {
				enable = false
			}
		}
	end
}
