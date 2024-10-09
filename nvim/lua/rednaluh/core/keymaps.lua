vim.g.mapleader = " "

local set = vim.keymap.set
local opts = { noremap = true, silent = true }

-- set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save", noremap = true })
-- set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit", noremap = true })
set("n", "<leader>sa", ":keepjumps normal! ggVG<cr>", { desc = "Select all", noremap = true })
opts.desc = "Add line below"
set("n", "<leader>o", "o<Esc>", opts)
opts.desc = "Add line above"
set("n", "<leader>O", "O<Esc>", opts)
set("n", "<Esc>", "<cmd>nohlsearch<CR>")
set("x", "<leader>p", "\"_dP", opts)

-- windows
-- set("n", "<leader>p", "<C-W>p", { desc = "Switch window" })

-- terminal
set("t", "<Esc>", [[<C-\><C-n>]], opts)

-- New tab
set("n", "<leader>te", ":tabedit<CR>", opts)
set("n", "<leader>tn", ":tabnew<CR>", opts)

-- Split window
opts.desc = "Split window"
set("n", "<leader>wh", ":split<Return>", opts)
opts.desc = "Split window vertically"
set("n", "<leader>ws", ":vsplit<Return>", opts)
opts.desc = "Split vertically to empty file"
set("n", "<leader>wn", ":vne<Return>", opts)

-- Move window
opts.desc = "Go to the left window"
set("n", "sh", "<C-W>h", opts)
opts.desc = "Go to the down window"
set("n", "sn", "<C-W>j", opts)
opts.desc = "Go to the right window"
set("n", "si", "<C-W>l", opts)
opts.desc = "Go to the up window"
set("n", "se", "<C-W>k", opts)

--Navigation
set({ "n", "v" }, "<C-d>", "<C-d>zz", { noremap = true })
set({ "n", "v" }, "<C-u>", "<C-u>zz", { noremap = true })
set({ "n", "v" }, "n", "nzz", { noremap = true })
set({ "n", "v" }, "N", "Nzz", { noremap = true })

--Telescope
opts.desc = "Find files"
set(
	"n",
	"<leader>ff",
	"<cmd>Telescope find_files<cr>",
	opts
)
opts.desc = "Find recent files"
set(
	"n",
	"<leader>fr",
	"<cmd>Telescope oldfiles<cr>",
	opts
)

opts.desc = "Find string"
set(
	"n",
	"<leader>fs",
	"<cmd>Telescope live_grep<cr>",
	opts
)

opts.desc = "Find string under cursor in cwd"
set(
	"n",
	"<leader>fc",
	"<cmd>Telescope grep_string<cr>",
	opts
)

opts.desc = "List buffes"
set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)

opts.desc = "List jump list"
set("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", opts)

opts.desc = "List all "
set(
	"n",
	"<leader>fm",
	"<cmd>Telescope <cr>",
	opts
)

-- DAP
set("n", "<F5>", ":lua require'dap'.continue()<CR>", { noremap = true, silent = true })
set("n", "<F2>", ":lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
set("n", "<F1>", ":lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
set("n", "<F3>", ":lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
set("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })
set(
	"n",
	"<leader>dB",
	":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ noremap = true, silent = true }
)
set(
	"n",
	"<leader>dl",
	":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
	{ noremap = true, silent = true }
)
set("n", "<leader>dR", ":lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })
set("n", "<leader>dgt", ":lua require'dap-go'.debug_test()<CR>", { noremap = true, silent = true })
set("i", "<C-c>", "<Esc>", opts)

-- VIM  for normal and visual mode
set({ "n", "v" }, "k", "n", opts)
set({ "n", "v" }, "K", "N", opts)
set({ "n", "v" }, "n", "j", opts)
set({ "n", "v" }, "N", "J", opts)
set({ "n", "v" }, "e", "k", opts)
set({ "n", "v" }, "E", "K", opts)
set({ "n", "v" }, "j", "e", opts)
set({ "n", "v" }, "J", "e", opts)
-- set("i", "ii", "<ESC>", opts )

-- oil
set("n", "-", "<cmd>lua require('oil').open_float()<CR>", { noremap = true, silent = true })

--visual studio
set("n", "<leader>vs", "<cmd>!devenv /edit %<cr>", { desc = "Edit file in Visual Studio", noremap = true, silent = true })

-- dotnet format
set({ "v", "n"}, "<leader>=", "<cmd>!dotnet format whitespace<cr>", { desc = "Format file ", noremap = true, silent = true })
