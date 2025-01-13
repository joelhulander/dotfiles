return {
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		priority = 1000
	},
	{
		"tanvirtin/monokai.nvim",
		name = "monokai",
		priority = 1000
	},
	{
		"navarasu/onedark.nvim",
		name = "onedark",
		priority = 1000,
		config = function ()
			require("onedark").setup({
				style = "darker",
			})
		end
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function ()
			require("catppuccin").setup({
				flavour = "mocha",
				-- transparent_background = true,
			})
		end
	}
}
