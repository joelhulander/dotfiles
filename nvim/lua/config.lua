local config = {
	plugins = {
		alpha = false,
		autopairs = true,
		blink = true,
		colorizer = true,
		comment = true,
		conform = true,
		crates = true,
		gitsigns = false,
		hardtime = false,
		harpoon = true,
		hawtkeys = true,
		help_vsplit = true,
		indent_blankline = true,
		lualine = true,
		markdown_preview = true,
		mini_diff = true,
		mini_git = true,
		nvim_cmp = false,
		nvim_navic = false,
		obsidian = true,
		oil = true,
		render_markdown = true,
		silicon = true,
		snacks = true,
		treesitter_context = true,
		treesitter = true,
		trouble = true,
		vim_be_good = false,
		which_key = true,

		-- DB
		dadbod_ui = false,
		dadbod = false,
		dbee = false,
		mssql = false,

		-- Debug
		go = true,
		nvim_dap = true,
		nvim_nio = true,

		-- LSP
		linting = true,
		lspconfig = false,
		mason = true,
		rustaceanvim = false,

		--Color schemes
		tokyonight = false,
		monokai = false,
		onedark = false,
		catppuccin = true
	}
}

if vim.fn.has('macunix') then
	config.plugins.mssql = false
end

return config 
