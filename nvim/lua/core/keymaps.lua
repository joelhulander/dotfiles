vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', {desc = 'Save'})
vim.keymap.set({'n', 'x'}, 'cp', '"+y')
vim.keymap.set({'n', 'x'}, 'cv', '"+p')
vim.keymap.set({'n', 'x'}, 'x', '"_x')
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>', { desc = 'Select all' })
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>', {desc = 'Quit'})
vim.keymap.set('n', '<leader>l', '<cmd>:Lazy<cr>', { desc = 'Lazy' })
vim.keymap.set('n', '<leader>t', '<cmd>:NvimTreeToggle<cr>', { desc = 'NvimTree' })

-- windows
vim.keymap.set('n', '<leader>p', '<C-W>p', { desc = 'Switch window' })
vim.keymap.set('n', '<leader>n', '<C-W>h', { desc = 'Go to the left window' })
vim.keymap.set('n', '<leader>e', '<C-W>j', { desc = 'Go to the down window' })
vim.keymap.set('n', '<leader>i', '<C-W>l', { desc = 'Go to the right window' })
vim.keymap.set('n', '<leader>u', '<C-W>k', { desc = 'Go to the up window' })

-- telescope
vim.keymap.set('n', '<leader>ff', '<cmd>:Telescope find_files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', '<cmd>:Telescope live_grep<cr>', { desc = 'Live grep' })
vim.keymap.set('n', '<leader>gf', '<cmd>:Telescope git_files<cr>', { desc = 'Git files' })

-- terminal
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- comment
vim.keymap.set('n', '<leader>c', 'gcc', { desc = 'Comment line' })
vim.keymap.set('v', '<leader>c', 'gc', { desc = 'Comment lines' })
