return {
	"nvim-telescope/telescope.nvim",
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
				-- mappings = {
				-- 	i = {
				-- 		["<C-k>"] = actions.move_selection_previous, -- move to prev result
				-- 		["<C-j>"] = actions.move_selection_next, -- move to next result
				-- 		["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				-- 	},
				-- },
			},
			pickers = {
				find_files = {
					mappings = {
						n = {
							["cd"] = function(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								local dir = vim.fn.fnamemodify(selection.path, ":p:h")
								require("telescope.actions").close(prompt_bufnr)
								-- Depending on what you want put `cd`, `lcd`, `tcd`
								vim.cmd(string.format("silent lcd %s", dir))
							end
						}
					}
				}
			}
		})
		telescope.load_extension("fzf")
		-- telescope.load_extension('lsp_handlers')
	end,
}
