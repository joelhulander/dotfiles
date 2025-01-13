return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	version = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = function()
		pcall(require("nvim-treesitter.install").update({ with_sync = true }))
	end,
	opts = {
		highlight = { enable = true, disable = { "txt" } },
		indent = { enable = true },
		context_commentstring = { enable = true, enable_autocmd = false },
		ensure_installed = {
			"lua",
			"javascript",
			"json",
			"javascript",
			"markdown",
			"markdown_inline",
			"c_sharp",
			"vim",
			"regex",
			"go",
			"kdl",
			"vimdoc",
			"svelte",
			"sql"

		},
		-- incremental_selection = {
		-- 	enable = true,
		-- 	keymaps = {
		-- 		init_selection = "<C-space>",
		-- 		node_incremental = "<C-space>",
		-- 		scope_incremental = "<nop>",
		-- 		node_decremental = "<bs>",
		-- 	},
		-- },
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
