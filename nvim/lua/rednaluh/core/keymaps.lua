vim.g.mapleader = " "

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save", noremap = true })
keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit", noremap = true })
keymap.set("n", "<leader>sa", ":keepjumps normal! ggVG<cr>", { desc = "Select all", noremap = true })
opts.desc = "Add line below"
keymap.set("n", "<leader>o", "o<Esc>", opts)
opts.desc = "Add line above"
keymap.set("n", "<leader>O", "O<Esc>", opts)
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- windows
keymap.set("n", "<leader>p", "<C-W>p", { desc = "Switch window" })

-- terminal
keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)

-- New tab
keymap.set("n", "<leader>te", ":tabedit<CR>", opts)
keymap.set("n", "<leader>tn", ":tabnew<CR>", opts)

-- Split window
opts.desc = "Split window"
keymap.set("n", "<leader>ss", ":split<Return>", opts)
opts.desc = "Split window vertically"
keymap.set("n", "<leader>sv", ":vsplit<Return>", opts)
opts.desc = "Split vertically to empty file"
keymap.set("n", "<leader>sn", ":vne<Return>", opts)

-- Move window
opts.desc = "Go to the left window"
keymap.set("n", "sh", "<C-W>h", opts)
opts.desc = "Go to the down window"
keymap.set("n", "sn", "<C-W>j", opts)
opts.desc = "Go to the right window"
keymap.set("n", "si", "<C-W>l", opts)
opts.desc = "Go to the up window"
keymap.set("n", "se", "<C-W>k", opts)

--Navigation
keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz", { noremap = true })
keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz", { noremap = true })
keymap.set({ "n", "v" }, "n", "nzz", { noremap = true })
keymap.set({ "n", "v" }, "N", "Nzz", { noremap = true })

--Telescope
opts.desc = "Find files"
keymap.set(
	"n",
	"<leader>ff",
	"<cmd>Telescope find_files<cr>",
	opts
)
opts.desc = "Find recent files"
keymap.set(
	"n",
	"<leader>fr",
	"<cmd>Telescope oldfiles<cr>",
	opts
)

opts.desc = "Find string"
keymap.set(
	"n",
	"<leader>fs",
	"<cmd>Telescope live_grep<cr>",
	opts
)

opts.desc = "Find string under cursor in cwd"
keymap.set(
	"n",
	"<leader>fc",
	"<cmd>Telescope grep_string<cr>",
	opts
)

opts.desc = "List buffes"
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)

opts.desc = "List jump list"
keymap.set("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", opts)

opts.desc = "List all keymaps"
keymap.set(
	"n",
	"<leader>fm",
	"<cmd>Telescope keymaps<cr>",
	opts
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
keymap.set("n", "-", "<cmd>lua require('oil').open_float()<CR>", { noremap = true, silent = true })

--visual studio
keymap.set("n", "<leader>vs", "<cmd>!devenv /edit %<cr>", { desc = "Edit file in Visual Studio", noremap = true, silent = true })

-- dotnet format
keymap.set({ "v", "n"}, "<leader>=", "<cmd>!dotnet format whitespace<cr>", { desc = "Format file ", noremap = true, silent = true })
