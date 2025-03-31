local config = require("config").plugins

return {
	"neovim/nvim-lspconfig",
	enabled = config.lspconfig ~= false,
	-- event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"Hoffs/omnisharp-extended-lsp.nvim",
		"Decodetalkers/csharpls-extended-lsp.nvim",
	},
	config = function()
		local lspconfig = require"lspconfig"

		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }

		local on_attach = function(_, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Go to definition"
			keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- show lsp definitions

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>lca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>lRn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>lD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "<leader>lk", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>lRs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		lspconfig.html.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.cssls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		local util = require("lspconfig.util")

		lspconfig.csharp_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = { "csharp-ls" },
			filetypes = {"cs", "razor", "csproj", "fs", "fsproj"},
			init_options = { AutomaticWorkspaceInit = true },
			handlers = {
				["textDocument/definition"] = require("csharpls_extended").handler,
			},
			root_dir = util.root_pattern("*.sln", "*.fsproj", "*.git"),
		})


		lspconfig.svelte.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = { "svelteserver", "--stdio" },
			filetypes = { "svelte" },
			root_dir = util.root_pattern("package.json", ".git" )
		})

		-- lspconfig.omnisharp.setup({
		-- 	cmd = {
		-- 		"omnisharp",
		-- 	},
		-- 	handlers = {
		-- 		["textDocument/definition"] = require("omnisharp_extended").handler,
		-- 	},
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- 	root_dir = util.root_pattern("*.sln", "*.csproj", "omnisharp.json", "function.json", "*.fsproj", "*.git"),
		-- 	init_options = {
		-- 		useModernNet = true,
		-- 		enableImportCompletion = true,
		-- 	},
		-- 	settings = {
		-- 		FormattingOptions = {
		-- 			EnableEditorConfigSupport = true,
		-- 			OrganizeImport = true
		-- 		},
		-- 		RoslynExtensionsOptions = {
		-- 			EnableAnalyzersSupport = true,
		-- 			AnalyzeOpenDocumentsOnly = true
		-- 		}
		-- 	}
		-- })
	end,
}
