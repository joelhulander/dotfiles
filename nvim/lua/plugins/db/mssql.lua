local config = require("config").plugins

return {
	"Kurren123/mssql.nvim",
	enabled = config.mssql ~= false,
	opts = {
		keymap_prefix = "<leader>.",
		tools_file = vim.fn.expand('~') .. "/.sqltools/MicrosoftSqlToolsServiceLayer.exe",
	},
	dependencies = { "folke/which-key.nvim" }
}
