local config = require("config").plugins

return {
	"williamboman/mason.nvim",
	enabled = config.mason ~= false,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
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
			-- list of servers for mason to install
			ensure_installed = {
				"csharp_ls",
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
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua", -- lua formatter
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
				-- "netcoredbg",
				"eslint_d",
			},
		})
	end,
}
