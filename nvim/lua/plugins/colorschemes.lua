local config = require("config").plugins

return {
	{
		"folke/tokyonight.nvim",
		enabled = config.tokyonight ~= false,
		name = "tokyonight",
		priority = 1000
	},
	{
		"tanvirtin/monokai.nvim",
		enabled = config.monokai ~= false,
		name = "monokai",
		priority = 1000
	},
	{
		"navarasu/onedark.nvim",
		enabled = config.onedark ~= false,
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
		enabled = config.catppuccin ~= false,
		name = "catppuccin",
		priority = 1000,
		config = function ()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
			})
		end
	}
}
