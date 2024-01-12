return {
	"leoluz/nvim-dap-go",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("dap-go").setup()
	end,
}
