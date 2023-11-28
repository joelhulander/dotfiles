return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local nvimtree = require("nvim-tree")
			nvimtree.setup({
				view = {
					width = 45,
					relativenumber = true,
				},
				update_cwd = true,
			})

			local keymap = vim.keymap
			keymap.set("n", "<leader>tt", "<cmd>:NvimTreeToggle<cr>",
				{ desc = "NvimTree", noremap = true, silent = true })
			keymap.set(
				"n",
				"<leader>tf",
				"<cmd>NvimTreeFindFileToggle<CR>",
				{ desc = "Toggle file explorer on current file", noremap = true, silent = true }
			)                                                                                                                     -- toggle file explorer on current file
			keymap.set("n", "<leader>tc", "<cmd>NvimTreeCollapse<CR>",
				{ desc = "Collapse file explorer", noremap = true, silent = true })                                               -- collapse file explorer
			keymap.set("n", "<leader>tr", "<cmd>NvimTreeRefresh<CR>",
				{ desc = "Refresh file explorer", noremap = true, silent = true })                                                -- refresh file explorer
		end,
	},
}

