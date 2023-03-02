return {
	'nvim-treesitter/nvim-treesitter',
	version = false,
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
	},
	build = function()
		pcall(require('nvim-treesitter.install').update { with_sync = true})
	end,
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		context_commentstring = { enable = true, enable_autocmd = false },
		ensure_installed = {
			'lua',
			'javascript',
			'json',
			'markdown',
			'c_sharp'
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = "<nop>",
				node_decremental = "<bs>",
			},
		},
	},
	config = function(_, opts)
		require('nvim-treesitter.configs').setup(opts)
	end,
}
