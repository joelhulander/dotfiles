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
			"																			",
			"	███████╗██╗    ██╗███████╗███████╗████████╗██████╗ ███████╗██╗   ██╗	",
			"	██╔════╝██║    ██║██╔════╝██╔════╝╚══██╔══╝██╔══██╗██╔════╝██║   ██║	",
			"	███████╗██║ █╗ ██║█████╗  █████╗     ██║   ██║  ██║█████╗  ██║   ██║	",
			"	╚════██║██║███╗██║██╔══╝  ██╔══╝     ██║   ██║  ██║██╔══╝  ╚██╗ ██╔╝	",
			"	███████║╚███╔███╔╝███████╗███████╗   ██║   ██████╔╝███████╗ ╚████╔╝ 	",
			"	╚══════╝ ╚══╝╚══╝ ╚══════╝╚══════╝   ╚═╝   ╚═════╝ ╚══════╝  ╚═══╝ 		",
			"																			",
		}
		dashboard.section.buttons.val = {
			dashboard.button("n", "  > New File", "<cmd>ene<CR>", opts),
			dashboard.button("SPC tt", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>", opts),
			dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>", opts),
			dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>", opts),
			dashboard.button(
				"SPC wr",
				"󰁯  > Restore Session For Current Directory",
				"<cmd>SessionRestore<CR>",
				opts
			),
			dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>", opts),
			-- Set menu
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
