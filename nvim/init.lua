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

-- Load core modules
require("options")   -- Vim options
require("keymaps")   -- Key mappings
require("autocommands") -- Autocommands


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

-- Set colorscheme (after plugins are loaded)
vim.cmd.colorscheme("catppuccin")
