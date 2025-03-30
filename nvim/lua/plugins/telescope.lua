local config = require("config").plugins

return {
	"nvim-telescope/telescope.nvim",
	enabled = config.telescope ~= false,
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")

		telescope.setup({
			find_files = {
				path_display = "truncate",
			},
			defaults = {
				layout_config = {},
				vimgrep_arguments = {
					'rg',
					'--color=never',
					'--no-heading',
					'--with-filename',
					'--line-number',
					'--column',
					'--smart-case',
					'--hidden'
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					mappings = {
						n = {
							["cd"] = function(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								local dir = vim.fn.fnamemodify(selection.path, ":p:h")
								require("telescope.actions").close(prompt_bufnr)
								vim.cmd(string.format("silent lcd %s", dir))
							end
						}
					}
				}
			}
		})
		telescope.load_extension("fzf")
	end,
}
