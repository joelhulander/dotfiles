return {
	{ 'neovim/nvim-lspconfig',
		config = function()
			local lsp = require'lspconfig'
			local pid = vim.fn.getpid()
			local omnisharp_bin = "/mnt/c/Users/joelhu/.omnisharp/OmniSharp.exe"
			local csharp_ls_bin = "C:/Users/JHU02/.dotnet/tools/csharp-ls.exe"
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local on_attach = function(client, bufnr)
				vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
				-- Mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
			end,
			lsp.csharp_ls.setup {
				cmd = { csharp_ls_bin },
				filetypes = { "cs" },
				init_options = { AutomaticWorkspaceInit = true },
				-- root_dir { see source file }
			}
--			lsp.omnisharp.setup {
--				cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
--				on_attach = on_attach,
--				capabilities = capabilities
--			}
		end,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
		},	
	},
	{ 'hrsh7th/nvim-cmp',
		config = function()
			local cmp = require'cmp'
			cmp.setup ({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-5),
					['<C-f>'] = cmp.mapping.scroll_docs(3),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'buffer' },
				})
			})
		end,
	},
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'L3MON4D3/LuaSnip',
	'saadparwaiz1/cmp_luasnip'
}

