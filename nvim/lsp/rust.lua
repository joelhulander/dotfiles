return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				buildScripts = {
					enable = true,
				}
			},
			procMacro = {
				enable = true
			},
			diagnostics = {
				enable = true,
				experimental = {
					enable = true,
				}
			}
		}
	}
}
