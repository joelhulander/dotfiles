return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"csharp_ls",
				"omnisharp",
				"lua_ls",
				"html",
				"jsonls",
				"cssls",
				"sqlls",
				"gopls",
				"ts_ls",
				"rust_analyzer",
				"svelte"
			},
			automatic_installation = true,
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua", 
				-- "csharpier",
				"trivy",
				"clang-format",
				"prettier",
				"prettierd",
				"gofumpt",
				"goimports-reviser",
				"golines",
				"delve",
				"cpptools",
				"netcoredbg",
				"eslint_d",
			},
		})
	end,
}
