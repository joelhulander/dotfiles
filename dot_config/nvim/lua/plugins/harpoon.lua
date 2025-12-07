return {
	"ThePrimeagen/harpoon",
	enabled = true,
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

		local set= vim.keymap.set
		set("n", "<C-1>", function()
			harpoon:list():select(1)
		end, { desc = "Go to file 1" })
		set("n", "<C-2>", function()
			harpoon:list():select(2)
		end, { desc = "Go to file 2" })
		set("n", "<C-3>", function()
			harpoon:list():select(3)
		end, { desc = "Go to file 3" })
		set("n", "<C-4>", function()
			harpoon:list():select(4)
		end, { desc = "Go to file 4" })
		set("n", "<C-5>", function()
			harpoon:list():select(5)
		end, { desc = "Go to file 5" })
		set("n", "<C-6>", function()
			harpoon:list():select(6)
		end, { desc = "Go to file 6" })

		-- Harpoon user interface.
		set("n", "<leader>hm", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Toggle Harpoon menu" })
		set("n", "<leader>ha", function()
			harpoon:list():add()
		end, { desc = "Add file to Harpoon" })
	end,
}
