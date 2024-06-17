vim.g.mapleader = " "

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save", noremap = true })
keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit", noremap = true })
keymap.set("n", "<leader>sa", ":keepjumps normal! ggVG<cr>", { desc = "Select all", noremap = true })
keymap.set("n", "<leader>o", "o<Esc>", { desc = "Add line below", noremap = true, silent = true })
keymap.set("n", "<leader>O", "O<Esc>", { desc = "Add line above", noremap = true, silent = true })
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- windows
keymap.set("n", "<leader>p", "<C-W>p", { desc = "Switch window" })

-- terminal
keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)

-- New tab
keymap.set("n", "te", ":tabedit<CR>", opts)

-- Split window
-- keymap.set("n", "ss", ":split<Return>", opts)
-- keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-W>h", { desc = "Go to the left window", noremap = true })
keymap.set("n", "sn", "<C-W>j", { desc = "Go to the down window", noremap = true })
keymap.set("n", "si", "<C-W>l", { desc = "Go to the right window", noremap = true })
keymap.set("n", "se", "<C-W>k", { desc = "Go to the up window", noremap = true })

--Navigation
keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz", { noremap = true })
keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz", { noremap = true })
keymap.set({ "n", "v" }, "n", "nzz", { noremap = true })
keymap.set({ "n", "v" }, "N", "Nzz", { noremap = true })

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
keymap.set({ "n", "v" }, "n", "j", opts)
keymap.set({ "n", "v" }, "N", "J", opts)
keymap.set({ "n", "v" }, "e", "k", opts)
keymap.set({ "n", "v" }, "E", "K", opts)
keymap.set({ "n", "v" }, "j", "e", opts)
keymap.set({ "n", "v" }, "J", "e", opts)
-- keymap.set("i", "ii", "<ESC>", opts )

-- oil
keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory", noremap = true, silent = true })

--visual studio
keymap.set("n", "<leader>vs", "<cmd>!devenv /edit %<cr>", { desc = "Edit file in Visual Studio", noremap = true, silent = true })
