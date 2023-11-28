vim.g.mapleader = " "
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save", noremap = true })
keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit", noremap = true })
keymap.set("n", "<leader>a", ":keepjumps normal! ggVG<cr>", { desc = "Select all", noremap = true })
keymap.set("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })
keymap.set("n", "<leader>o", "o<Esc>", opts)
keymap.set("n", "<leader>O", "O<Esc>", opts)
-- windows
keymap.set("n", "<leader>p", "<C-W>p", { desc = "Switch window" })
--
-- terminal
keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)

-- New tab
keymap.set("n", "te", ":tabedit", opts)
-- keymap.set("n", "<tab>", ":tabnext<Return>", opts)
-- keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-W>h", { desc = "Go to the left window", noremap = true })
keymap.set("n", "se", "<C-W>j", { desc = "Go to the down window", noremap = true })
keymap.set("n", "si", "<C-W>l", { desc = "Go to the right window", noremap = true })
keymap.set("n", "sn", "<C-W>k", { desc = "Go to the up window", noremap = true })

keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz", { noremap = true })
keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz", { noremap = true })
keymap.set({ "n", "v" }, "n", "nzz", { noremap = true })
keymap.set({ "n", "v" }, "N", "Nzz", { noremap = true })
-- keymap.set({ "n", "v" }, "/<CR>", "zz", { noremap = true })

-- Tabs
-- Move to previous/next
keymap.set("n", "<tab>", "<Cmd>BufferNext<CR>", opts)
keymap.set("n", "<s-tab>", "<Cmd>BufferPreviouns<CR>", opts)
-- Re-order to previous/next
keymap.set("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
keymap.set("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
-- Goto buffer in position...
keymap.set("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
keymap.set("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
keymap.set("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
keymap.set("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
keymap.set("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
keymap.set("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
keymap.set("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
keymap.set("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
keymap.set("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
keymap.set("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
-- Pin/unpin buffer
keymap.set("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
-- Close buffer
keymap.set("n", "<leader>ct", "<Cmd>BufferClose<CR>", { desc = "Close tab", noremap = true, silent = true })
-- Magic buffer-picking mode
keymap.set("n", "<C-p>", "<Cmd>BufferPick<CR>", opts)
