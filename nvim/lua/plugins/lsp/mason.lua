local config = require("config").plugins

return {
	"williamboman/mason.nvim",
	enabled = config.mason ~= false,
	version = '1.11.0',
	config = function()
		local mason = require("mason")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

	end,
}
