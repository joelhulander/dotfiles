local config = require("config").plugins

return {
	"stevearc/conform.nvim",
	enabled = config.conform ~= false,
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				-- javascriptreact = { "prettier" },
				-- typescriptreact = { "prettier" },
				-- svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				-- yaml = { "prettier" },
				-- cs = { "clang-format" },
				cs = { "dotnet_format" },
				markdown = { "prettier" },
				-- graphql = { "prettier" },
				lua = { "stylua" },
				-- python = { "isort", "black" },
				go = { "gofumpt", "goimports-reviser", "golines" },
			},
			formatters = {
				dotnet_format = {
					command = "dotnet",
					args = { "format", "whitespace" },
					stdin = false,
				},
			},
		})

	end,
}

