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
				--         ["<C-j>"] = actions.move_selection_next, -- move to next result
				--       	["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				--     	},
				--   	},
			},
		})
		telescope.load_extension("fzf")
		-- telescope.load_extension('lsp_handlers')
		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>",
			{ desc = "Fuzzy find files in cwd", noremap = true, silent = true })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>",
			{ desc = "Fuzzy find recent files", noremap = true, silent = true })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>",
			{ desc = "Find string in cwd", noremap = true, silent = true })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>",
			{ desc = "Find string under cursor in cwd", noremap = true, silent = true })
	end,
}

