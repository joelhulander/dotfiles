return {
	"ThePrimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
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

		harpoon.setup(opts)
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		local keymap = vim.keymap
		keymap.set("n", "<C-h>", function()
			ui.nav_file(1)
		end, { desc = "Go to file 1" })
		keymap.set("n", "<C-n>", function()
			ui.nav_file(2)
		end, { desc = "Go to file 2" })
		keymap.set("n", "<C-e>", function()
			ui.nav_file(3)
		end, { desc = "Go to file 3" })
		keymap.set("n", "<C-i>", function()
			ui.nav_file(4)
		end, { desc = "Go to file 4" })

		-- Harpoon next and previous.
		keymap.set("n", "<leader>hn", function()
			ui.nav_next()
		end, { desc = "Go to next" })
		keymap.set("n", "<leader>hp", function()
			ui.nav_prev()
		end, { desc = "Go to previous" })

		-- Harpoon user interface.
		keymap.set("n", "<leader>hm", ui.toggle_quick_menu, { desc = "Toggle Harpoon menu" })
		keymap.set("n", "<leader>a", mark.add_file, { desc = "Add file to Harpoon" })
	end,
}
