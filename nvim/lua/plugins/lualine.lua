local config = require("config").plugins

return {
	"nvim-lualine/lualine.nvim",
	enabled = config.lualine ~= false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		lualine.setup({
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
						newfile_status = false, -- Display new file status (new file means no write after created)
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
		})
	end,
}
