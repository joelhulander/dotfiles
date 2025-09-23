local capabilities = {
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}
	}
}

capabilities = require("blink.cmp").get_lsp_capabilities(capabilities);

local set = vim.keymap.set -- for conciseness
local opts = { noremap = true, silent = true }



local on_attach = function(_, bufnr)
	opts.buffer = bufnr

	opts.desc = "See available code actions"
	set({ "n", "v" }, "<leader>lca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

	opts.desc = "Smart rename"
	set("n", "<leader>lRn", vim.lsp.buf.rename, opts) -- smart rename

	opts.desc = "Show buffer diagnostics"
	set("n", "<leader>lD", function() Snacks.picker.diagnostics_buffer() end, opts) -- show  diagnostics for file

	opts.desc = "Show line diagnostics"
	set("n", "<leader>ld", vim.diagnostic.open_float, opts) -- show diagnostics for line

	opts.desc = "Show documentation for what is under cursor"
	set("n", "<leader>lk", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

	opts.desc = "Go to definition"
	set("n", "gd", function() Snacks.picker.lsp_definitions() end, opts)

	opts.desc = "Go to declaration"
	set("n", "gD", function() Snacks.picker.lsp_declarations() end, opts)

	opts.desc = "Go to implementation"
	set("n", "gI", function() Snacks.picker.lsp_implementations() end, opts)

	opts.desc = "Go to t[y]pe definition"
	set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, opts)

	opts.desc = "LSP Symbols"
	set("n", "<leader>ls", function() Snacks.picker.lsp_symbols() end, opts)

	opts.desc = "LSP Workspace Symbols"
	set("n", "<leader>lS", function() Snacks.picker.lsp_workspace_symbols() end, opts)


end

vim.lsp.config("*", {
	capabilities = capabilities,
	on_attach = on_attach,
	root_markers = { ".git" },
})

vim.lsp.enable({'lua-ls', 'gopls' , 'csharp-ls', 'rust'})

