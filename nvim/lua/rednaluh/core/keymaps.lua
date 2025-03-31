vim.g.mapleader = " "

local set = vim.keymap.set
local opts = { noremap = true, silent = true }

-- set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save", noremap = true })
-- set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit", noremap = true })
set("n", "<leader>sa", ":keepjumps normal! ggVG<cr>", { desc = "Select all", noremap = true })
set("n", "<Esc>", "<cmd>nohlsearch<CR>")
set("x", "<leader>p", "\"_dP", opts)
set("i", "<C-c>", "<Esc>", opts)

-- windows
-- set("n", "<leader>p", "<C-W>p", { desc = "Switch window" })

-- folding

opts.desc = "Fold to bottom"
set("n", "<leader><leader>fG", "zfG", opts)

-- terminal
set("t", "<Esc>", [[<C-\><C-n>]], opts)

-- New tab
opts.desc = "Open new tab"
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
opts.desc = "List registers"
set(
	"n",
	"<leader>fr",
	"<cmd>Telescope registers<cr>",
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

opts.desc = "List all telescope commands"
set(
	"n",
	"<leader>fm",
	"<cmd>Telescope <cr>",
	opts
)

-- DAP
opts.desc = "Continue/Run"
set("n", "<F5>", ":lua require'dap'.continue()<CR>", opts) 
opts.desc = "Step over"
set("n", "<F2>", ":lua require'dap'.step_over()<CR>", opts)
opts.desc = "Step into"
set("n", "<F1>", ":lua require'dap'.step_into()<CR>", opts)
opts.desc = "Step out"
set("n", "<F3>", ":lua require'dap'.step_out()<CR>", opts)
opts.desc = "Toggle breakpoint"
set("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
opts.desc = "Set breakpoint with condition"
set(
	"n",
	"<leader>dB",
	":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	opts
)
opts.desc = "Log point message"
set(
	"n",
	"<leader>dl",
	":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
	opts
)
opts.desc = "Repl open"
set("n", "<leader>dR", ":lua require'dap'.repl.open()<CR>", opts)
opts.desc = "Debug test"
set("n", "<leader>dgt", ":lua require'dap-go'.debug_test()<CR>", opts)

-- DAP UI
opts.desc = "Open DAP UI"
set("n", "<leader>du", ":lua require'dapui'.toggle()<CR>", opts)


-- VIM  for normal and visual mode
set({ "n", "v" }, "k", "n", opts)
set({ "n", "v" }, "K", "N", opts)
set({ "n", "v" }, "n", "j", opts)
set({ "n", "v" }, "N", "J", opts)
set({ "n", "v" }, "e", "k", opts)
set({ "n", "v" }, "E", "K", opts)
set({ "n", "v" }, "j", "e", opts)
set({ "n", "v" }, "J", "e", opts)

-- oil
set("n", "-", "<cmd>lua require('oil').open_float()<CR>", { noremap = true, silent = true })

--visual studio
set("n", "<leader>vs", "<cmd>!devenv /edit %<cr>", { desc = "Edit file in Visual Studio", noremap = true, silent = true })

-- dotnet format
set({ "v", "n"}, "<leader>=", "<cmd>!dotnet format whitespace<cr>", { desc = "Format file ", noremap = true, silent = true })

-- obsidian
set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open note in Obsidian", noremap = true, silent = true})
set("n", "<leader>od", "<cmd>ObsidianToday<CR>", { desc = "Open todays daily note", noremap = true, silent = true})
set("n", "<leader>ft", "<cmd>ObsidianTags<CR>", { desc = "List tags", noremap = true, silent = true})
set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Obsidian search", noremap = true, silent = true})
set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert template", noremap = true, silent = true})

-- mini.nvim
set("n", "<leader>go", "<cmd>lua MiniDiff.toggle_overlay()<CR>", { desc = "Toggle overlay", noremap = true, silent = true})
set("n", "<leader>gt", "<cmd>lua MiniDiff.toggle()<CR>", { desc = "Toggle mini diff", noremap = true, silent = true})
set("n", "<leader>gd", "<cmd>Git diff<CR>", { desc = "Diff", noremap = true, silent = true})
set("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Commit", noremap = true, silent = true})
set("n", "<leader>gp", "<cmd>Git pull<CR>", { desc = "Pull", noremap = true, silent = true})
set("n", "<leader>gP", "<cmd>Git push<CR>", { desc = "Push", noremap = true, silent = true})
set("n", "<leader>gs", "<cmd>Git status<CR>", { desc = "Status", noremap = true, silent = true})
set("n", "<leader>gl", "<cmd>Git log<CR>", { desc = "Log", noremap = true, silent = true})

