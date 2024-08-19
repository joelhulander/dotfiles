return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local opts = { noremap = true, silent = true }

		-- Set header
		dashboard.section.header.val = {
			"												   ",
			"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
			"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
			"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
			"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
			"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
			"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
		}
		dashboard.section.buttons.val = {
			dashboard.button("n", "  > New File", "<cmd>ene<CR>", opts),
			dashboard.button("-", " > Open parent directory", "<cmd>Oil<CR>", opts),
			dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>", opts),
		}

		alpha.setup(dashboard.opts)

		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
