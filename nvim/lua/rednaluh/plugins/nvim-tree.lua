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
		end,
	},
}
