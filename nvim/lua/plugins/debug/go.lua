local config = require("config").plugins

return {
	"leoluz/nvim-dap-go",
	enabled = config.go ~= false,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("dap-go").setup()
	end,
}
