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

-- DAP
keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
keymap.set("n", "<F10>", ":lua require'dap'.step_over()<CR>")
keymap.set("n", "<F11>", ":lua require'dap'.step_into()<CR>")
keymap.set("n", "<F12>", ":lua require'dap'.step_out()<CR>")
keymap.set("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>")
keymap.set("n", "<leader>dB", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
keymap.set("n", "<leader>dl", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
keymap.set("n", "<leader>dt", ":lua require'dap-go'.debug_test()<CR>")
