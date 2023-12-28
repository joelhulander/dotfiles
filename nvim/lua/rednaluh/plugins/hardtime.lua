return {
	"m4xshen/hardtime.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	opts = {
		disable_mouse = false,
		max_time = 1000,
		max_count = 2,
		enabled = false,
	},
}
