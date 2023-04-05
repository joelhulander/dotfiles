vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', {desc = 'Save'})
vim.keymap.set({'n', 'x'}, 'cp', '"+y')
vim.keymap.set({'n', 'x'}, 'cv', '"+p')
vim.keymap.set({'n', 'x'}, 'x', '"_x')
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>', {desc = 'Quit'})
vim.keymap.set('n', '<leader>l', '<cmd>:Lazy<cr>', { desc = 'Lazy' })
vim.keymap.set('n', '<leader>t', '<cmd>:NvimTreeToggle<cr>', { desc = 'NvimTree' })

-- windows
vim.keymap.set('n', '<leader>p', '<C-W>p', { desc = 'Other window' })

-- telescope
vim.keymap.set('n', '<leader>ff', '<cmd>:Telescope find_files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', '<cmd>:Telescope live_grep<cr>', { desc = 'Live grep' })
vim.keymap.set('n', '<leader>gf', '<cmd>:Telescope git_files<cr>', { desc = 'Git files' })
vim.keymap.set('n', '<leader>fb', '<cmd>:Telescope buffers<cr>', { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fh', '<cmd>:Telescope help_tags<cr>', { desc = 'Help tags' })

-- terminal
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
