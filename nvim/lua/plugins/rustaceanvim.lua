local config = require('config').plugins

return {
	'mrcjkb/rustaceanvim',
	ft = { "rust" },
	enabled = config.rustaceanvim ~= false,
	version = '^6',
	lazy = false,
	opts = {
		default_settings = {
			-- rust-analyzer language server configuration
			["rust-analyzer"] = {
				cargo = {
					allFeatures = true,
					loadOutDirsFromCheck = true,
					buildScripts = {
						enable = true,
					},
				},
				-- Add clippy lints for Rust if using rust-analyzer
				checkOnSave = diagnostics == "rust-analyzer",
				-- Enable diagnostics if using rust-analyzer
				diagnostics = {
					enable = diagnostics == "rust-analyzer",
				},
				procMacro = {
					enable = true,
					ignored = {
						["async-trait"] = { "async_trait" },
						["napi-derive"] = { "napi" },
						["async-recursion"] = { "async_recursion" },
					},
				},
				files = {
					excludeDirs = {
						".direnv",
						".git",
						".github",
						".gitlab",
						"bin",
						"node_modules",
						"target",
						"venv",
						".venv",
					},
				},
			},
		}
	},
	config = function (_, opts)
		local codelldb = vim.fn.exepath("codelldb")
		local codelldb_lib_ext = io.popen("uname"):read("*l") == "Linux" and ".so" or ".dylib"
		local library_path = vim.fn.expand("$MASON/opt/lldb/lib/liblldb" .. codelldb_lib_ext)
		opts.dap = {
			adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
		}
		vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})

	end
}
