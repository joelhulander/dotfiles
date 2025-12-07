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

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end

_G.last_project_buffers = _G.last_project_buffers or {}
_G.project_terminals = _G.project_terminals or {}

require("keymaps")
require("options")
require("autocommands")
require("terminal")

local dir = vim.fn.stdpath("data") .. "/jh"
local files = vim.fn.readdir(dir)
local personal_settings_file
local cwd_name = vim.fn.fnamemodify(vim.loop.cwd(), ":t")

for _, f in ipairs(files) do
	if f:lower():match(cwd_name:lower()) then
		personal_settings_file = f
	break
	end
end

if not personal_settings_file and #files > 0 then
	personal_settings_file = 'personal_settings.json'
end

if personal_settings_file then
	local f = io.open(vim.fs.joinpath(dir, personal_settings_file), "r")
	if f then
		local content = f:read("*a")
		f:close()
		vim.g.personal_settings = vim.json.decode(content)
	end
end

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
