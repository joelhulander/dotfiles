-- lua/plugins/lsp.lua
local config = require("config").plugins

-- ====== Capabilities ======
local capabilities = {
	textDocument = {
		foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
	},
}
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

-- ====== on_attach: keymaps ======
local on_attach = function(_, bufnr)
	local set = vim.keymap.set
	local opts = { buffer = bufnr, noremap = true, silent = true }

	-- Core LSP mappings
	set("n", "gd", function() Snacks.picker.lsp_definitions() end, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
	set("n", "gD", function() Snacks.picker.lsp_declarations() end, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
	set("n", "gI", function() Snacks.picker.lsp_implementations() end, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
	set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, vim.tbl_extend("force", opts, { desc = "Type definition" }))
	set("n", "<leader>lk", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover docs" }))
	set("n", "<leader>lca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
	set("n", "<leader>lRn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
	set("n", "<leader>lD", function() Snacks.picker.diagnostics_buffer() end, vim.tbl_extend("force", opts, { desc = "Buffer diagnostics" }))
	set("n", "<leader>ld", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))
	set("n", "<leader>ls", function() Snacks.picker.lsp_symbols() end, vim.tbl_extend("force", opts, { desc = "LSP symbols" }))
	set("n", "<leader>lS", function() Snacks.picker.lsp_workspace_symbols() end, vim.tbl_extend("force", opts, { desc = "Workspace symbols" }))
end

-- ====== Default config for all servers ======
vim.lsp.config("*", {
	capabilities = capabilities,
	on_attach = on_attach,
	root_markers = { ".git" },
})

-- ====== Lua LSP ======
vim.lsp.config("luals", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
		},
	},
})

-- ====== Go LSP ======
vim.lsp.config("gopls", {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.work", "go.mod", "go.sum", ".git" },
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = { unusedparams = true },
		},
	},
})

-- ====== Svelte LSP ======
vim.lsp.config("svelte", {
	cmd = { "svelteserver", "--stdio" },
	filetypes = { "svelte" },
	root_markers = { "package.json" },
})


-- ====== Rust LSP ======
vim.lsp.config("rust_analyzer", {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", ".git" },
	settings = {
		["rust-analyzer"] = {
			cargo = { allFeatures = true },
			checkOnSave = {
				allTargets = true,
				enable = true
			},
			assist = { importGranularity = "module", importPrefix = "by_self" },
			diagnostics = { enable = true, disabled = { "unresolved-proc-macro" } },
			completion = { postfix = { enable = true } },
			rustfmt = { enableRangeFormatting = true },
		},
	},
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)

		-- Auto-format on save
		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("RustFmt", { clear = true }),
				buffer = bufnr,
				callback = function() vim.lsp.buf.format({ async = false }) end,
			})
		end

	end,
})

-- ====== C# LSP ======
if config.csharp_lsp ~= false then
	local csharp_servers = { "omnisharp", "csharpls-extended" }
	for _, srv in ipairs(csharp_servers) do
		vim.lsp.config(srv, {
			cmd = srv == "omnisharp" and { "omnisharp" } or { "csharp-ls" },
			filetypes = srv == "omnisharp" and { "cs", "razor", "csproj", "fs", "fsproj" } or nil,
			init_options = srv == "csharp-ls" and { AutomaticWorkspaceInit = true } or nil,
			handlers = srv == "csharp-ls" and { ["textDocument/definition"] = require("csharpls_extended").handler } or nil,
			capabilities = capabilities,
			on_attach = on_attach,
			root_markers = srv == "csharp-ls" and { "sln", "*.fsproj" } or nil,
		})
	end
end

-- ====== Enable servers ======
vim.lsp.enable({ "luals", "gopls", "csharp_ls", "rust_analyzer", "svelte" })

