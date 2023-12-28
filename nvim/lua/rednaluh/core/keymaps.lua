vim.g.mapleader = " "

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save", noremap = true })
keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit", noremap = true })
keymap.set("n", "<leader>sa", ":keepjumps normal! ggVG<cr>", { desc = "Select all", noremap = true })
-- keymap.set("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })
keymap.set("n", "<leader>o", "o<Esc>", { desc = "Add line below", noremap = true, silent = true })
keymap.set("n", "<leader>O", "O<Esc>", { desc = "Add line above", noremap = true, silent = true })

-- windows
keymap.set("n", "<leader>p", "<C-W>p", { desc = "Switch window" })

-- terminal
keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)

-- New tab
keymap.set("n", "te", ":tabedit", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-W>h", { desc = "Go to the left window", noremap = true })
keymap.set("n", "sj", "<C-W>j", { desc = "Go to the down window", noremap = true })
keymap.set("n", "sl", "<C-W>l", { desc = "Go to the right window", noremap = true })
keymap.set("n", "sk", "<C-W>k", { desc = "Go to the up window", noremap = true })

--Navigation
keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz", { noremap = true })
keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz", { noremap = true })
keymap.set({ "n", "v" }, "n", "nzz", { noremap = true })
keymap.set({ "n", "v" }, "N", "Nzz", { noremap = true })

--NvimTree
keymap.set("n", "<leader>tt", "<cmd>:NvimTreeToggle<cr>", { desc = "NvimTree", noremap = true, silent = true })
keymap.set(
	"n",
	"<leader>tf",
	"<cmd>NvimTreeFindFileToggle<CR>",
	{ desc = "Toggle file explorer on current file", noremap = true, silent = true }
) -- toggle file explorer on current file
keymap.set(
	"n",
	"<leader>tc",
	"<cmd>NvimTreeCollapse<CR>",
	{ desc = "Collapse file explorer", noremap = true, silent = true }
) -- collapse file explorer
keymap.set(
	"n",
	"<leader>tr",
	"<cmd>NvimTreeRefresh<CR>",
	{ desc = "Refresh file explorer", noremap = true, silent = true }
) -- refresh file explorer

--Telescope
keymap.set(
	"n",
	"<leader>ff",
	"<cmd>Telescope find_files<cr>",
	{ desc = "Fuzzy find files in cwd", noremap = true, silent = true }
)
keymap.set(
	"n",
	"<leader>fr",
	"<cmd>Telescope oldfiles<cr>",
	{ desc = "Fuzzy find recent files", noremap = true, silent = true }
)
keymap.set(
	"n",
	"<leader>fs",
	"<cmd>Telescope live_grep<cr>",
	{ desc = "Find string in cwd", noremap = true, silent = true }
)
keymap.set(
	"n",
	"<leader>fc",
	"<cmd>Telescope grep_string<cr>",
	{ desc = "Find string under cursor in cwd", noremap = true, silent = true }
)
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "List buffers", noremap = true, silent = true })
keymap.set("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", { desc = "List jump list", noremap = true, silent = true })
keymap.set(
	"n",
	"<leader>fm",
	"<cmd>Telescope keymaps<cr>",
	{ desc = "List all keymaps", noremap = true, silent = true }
)

-- DAP
keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>", { noremap = true, silent = true })
keymap.set("n", "<F2>", ":lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
keymap.set("n", "<F1>", ":lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
keymap.set("n", "<F3>", ":lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })
keymap.set(
	"n",
	"<leader>dB",
	":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ noremap = true, silent = true }
)
keymap.set(
	"n",
	"<leader>dl",
	":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
	{ noremap = true, silent = true }
)
keymap.set("n", "<leader>dR", ":lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>dgt", ":lua require'dap-go'.debug_test()<CR>", { noremap = true, silent = true })
keymap.set("i", "<C-c>", "<Esc>", opts)

-- VIM keymaps for normal and visual mode
keymap.set({ "n", "v" }, "k", "n", opts)
keymap.set({ "n", "v" }, "K", "N", opts)
-- keymap.set({ "n", "v" }, "r", "s", opts)
-- keymap.set({ "n", "v" }, "R", "S", opts)
-- keymap.set({ "n", "v" }, "s", "d", opts)
-- keymap.set({ "n", "v" }, "S", "D", opts)
-- keymap.set({ "n", "v" }, "t", "f", opts)
-- keymap.set({ "n", "v" }, "T", "F", opts)
-- keymap.set({ "n", "v" }, "d", "g", opts)
-- keymap.set({ "n", "v" }, "D", "G", opts)
keymap.set({ "n", "v" }, "n", "j", opts)
keymap.set({ "n", "v" }, "N", "J", opts)
keymap.set({ "n", "v" }, "e", "k", opts)
keymap.set({ "n", "v" }, "E", "K", opts)
keymap.set({ "n", "v" }, "i", "l", opts)
keymap.set({ "n", "v" }, "I", "L", opts)
-- keymap.set({ "n", "v" }, "o", ";", opts)
-- keymap.set({ "n", "v" }, "O", ":", opts)
-- keymap.set({ "n", "v" }, "f", "e", opts)
-- keymap.set({ "n", "v" }, "F", "E", opts)
-- keymap.set({ "n", "v" }, "p", "r", opts)
-- keymap.set({ "n", "v" }, "P", "R", opts)
-- keymap.set({ "n", "v" }, "g", "t", opts)
-- keymap.set({ "n", "v" }, "G", "T", opts)
keymap.set({ "n", "v" }, "j", "e", opts)
keymap.set({ "n", "v" }, "J", "e", opts)
keymap.set({ "n", "v" }, "l", "u", opts)
keymap.set({ "n", "v" }, "L", "U", opts)
keymap.set({ "n", "v" }, "u", "i", opts)
keymap.set({ "n", "v" }, "U", "I", opts)
-- keymap.set({ "n", "v" }, "y", "o", opts)
-- keymap.set({ "n", "v" }, "Y", "O", opts)
-- keymap.set({ "n", "v" }, ";", "p", opts)
-- keymap.set({ "n", "v" }, ":", "P", opts)
