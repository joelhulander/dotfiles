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
_G.last_worktree_paths = _G.last_worktree_paths or {}

require("keymaps")
require("options")
require("autocommands")
require("terminal")
require("functions")

-- Load settings (merged defaults + machine-specific)
vim.g.personal_settings = require("settings").load()

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
