local config = require("config").plugins

return {
	"nvim-tree/nvim-tree.lua",
	enabled = config.nvim_tree ~= false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local nvimtree = require("nvim-tree")
		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			-- default mappings
			api.config.mappings.default_on_attach(bufnr)

			-- custom mappings
			vim.keymap.set("n", "j", api.fs.rename_basename, { noremap = true, silent = true })
			vim.keymap.del("n", "e", { buffer = bufnr })
		end

		-- pass to setup along with your other options
		nvimtree.setup({
			on_attach = my_on_attach,
			view = {
				width = 45,
				relativenumber = true,
			},
			update_cwd = true,
		})
	end,
}
