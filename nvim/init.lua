local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)


local files = vim.fn.readdir(vim.fn.stdpath('data') .. '/jh')

local personal_settings_file_path

if #files > 1 then
	vim.ui.select(files, {
		prompt = 'Select personal settings file:',
		format_item = function(item)
			return item
		end,
	}, function(choice)
			personal_settings_file_path = choice
		end
	)
else
	personal_settings_file_path = 'personal_settings.json'
end

local personal_settings = io.open(vim.fn.stdpath('data') .. '/jh/' .. personal_settings_file_path, 'r')

if personal_settings then
	local content = personal_settings:read("*a")
	personal_settings:close()
	vim.g.personal_settings = vim.json.decode(content)
end

if not _G.last_project_buffers then
  _G.last_project_buffers = {}
end

require("keymaps")
require("options")
require("autocommands")

-- Initialize lazy.nvim with plugins
require("lazy").setup({
	-- Plugin specs or imports
	{ import = "plugins" },
	{ import = "plugins.lsp" },
	{ import = "plugins.debug" },
	{ import = "plugins.db" },
}, {
		-- Lazy options
		checker = {
			enabled = true,
			notify = false,
		},
		performance = {
			rtp = {
				disabled_plugins = {
					"gzip",
					"matchit",
					"matchparen",
					"netrwPlugin",
					"tarPlugin",
					"tohtml",
					"zipPlugin",
				},
			},
		},
		change_detection = {
			notify = false,
		},
	})

require("lsp")
require("advanced_keymaps")

-- Set colorscheme (after plugins are loaded)
vim.cmd.colorscheme("catppuccin")
