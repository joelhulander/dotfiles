return {
	"leoluz/nvim-dap-go",
	enabled = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("dap-go").setup()
	end,
}
