local config = require("config").plugins
local lazy_status = require("lazy.status")

local opts = {
	options = {
		disabled_filetypes = { "NvimTree" },
	},
	sections = {
		lualine_a = {
			{
				"mode",
			},
		},
		lualine_b = {
			{
				"filename",
				file_status = true, -- Displays file status (readonly status, modified status)
				newfile_status = true, -- Display new file status (new file means no write after created)
				-- 1: Relative path
				-- 2: Absolute path
				-- 3: Absolute path, with tilde as the home directory
				path = 3, -- 0: Just the filename

				shorting_target = 40, -- Shortens path to leave 40 spaces in the window
				-- for other components. (terrible name, any suggestions?)
				symbols = {
					modified = "[+]", -- Text to show when the file is modified.
					readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "[No Name]", -- Text to show for unnamed buffers.
					newfile = "[New]", -- Text to show for newly created file before first write
				},
			},
		},
		-- lualine_c = {
		-- 	require('mssql').lualine_component,
		-- },
		lualine_x = {
			{
				lazy_status.updates,
				cond = lazy_status.has_updates,
				color = { fg = "#ff9e64" },
			},
			{ "encoding" },
			{ "fileformat" },
			{ "filetype" },
		},
	},
}
local lualine =
{
	"nvim-lualine/lualine.nvim",
	enabled = config.lualine ~= false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"Kurren123/mssql.nvim"
	},
	config = function()
		local lualine = require("lualine")

		lualine.setup(opts)
	end,
}

if vim.fn.has('macunix') then
	lualine.dependencies = {
		"nvim-tree/nvim-web-devicons"
	}
end

return lualine
