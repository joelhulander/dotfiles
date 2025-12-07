return {
	"Kurren123/mssql.nvim",
	enabled = false,
	opts = {
		keymap_prefix = "<leader>.",
		tools_file = vim.fn.expand('~') .. "/.sqltools/MicrosoftSqlToolsServiceLayer.exe",
	},
	dependencies = { "folke/which-key.nvim" }
}
