return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		global_settings = {
			save_on_toggle = false,
			save_on_change = true,
			enter_on_sendcmd = false,
			tmux_autoclose_windows = false,
			excluded_filetypes = { "harpoon", "alpha", "dashboard", "gitcommit" },
			mark_branch = false,
		},
	},
	config = function(_, opts)
		local harpoon = require("harpoon")

		harpoon:setup(opts)

		local keymap = vim.keymap
		keymap.set("n", "<C-h>", function()
			harpoon:list():select(1)
		end, { desc = "Go to file 1" })
		keymap.set("n", "<C-n>", function()
			harpoon:list():select(2)
		end, { desc = "Go to file 2" })
		keymap.set("n", "<C-e>", function()
			harpoon:list():select(3)
		end, { desc = "Go to file 3" })

		-- Harpoon user interface.
		keymap.set("n", "<leader>hm", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Toggle Harpoon menu" })
		keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end, { desc = "Add file to Harpoon" })
	end,
}
