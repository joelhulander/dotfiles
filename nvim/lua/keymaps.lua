vim.g.mapleader = " "

local set = vim.keymap.set
local opts = { noremap = true, silent = true }

set("n", "<leader>sa", ":keepjumps normal! ggVG<cr>", { desc = "Select all", noremap = true })
set("n", "<Esc>", "<cmd>nohlsearch<CR>")
set("x", "<leader>p", "\"_dP", opts)

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

--Snacks
opts.desc = "Smart Find Files"
set("n", "<leader><space>",	function() Snacks.picker.smart() end, opts)

opts.desc = "Buffers"
set("n", "<leader>fb", function() Snacks.picker.buffers() end, opts)

opts.desc = "Find files"
set("n", "<leader>ff", function() Snacks.picker.files() end, opts)

opts.desc = "Find git files"
set("n", "<leader>fg", function() Snacks.picker.git_files() end, opts)

opts.desc = "Registers"
set("n", '<leader "', function() Snacks.picker.registers() end, opts)

opts.desc = "Grep"
set("n", "<leader>/", function() Snacks.picker.grep() end, opts)

opts.desc = "Command history"
set("n", "<leader>:", function() Snacks.picker.command_history() end, opts)

opts.desc = "Notification history"
set("n", "<leader>n", function() Snacks.picker.notifications() end, opts)

opts.desc = "File Explorer"
set("n", "<leader>e", function() Snacks.picker.explorer() end, opts)

opts.desc = "Git Branches" 
set("n", "<leader>gb", function() Snacks.picker.git_branches() end, opts)

opts.desc = "Git Log" 
set("n", "<leader>gl", function() Snacks.picker.git_log() end, opts)

opts.desc = "Git Log Line"
set("n", "<leader>gL", function() Snacks.picker.git_log_line() end, opts)
	
opts.desc = "Git Status" 
set("n", "<leader>gs", function() Snacks.picker.git_status() end, opts)

opts.desc = "Git Stash" 
set("n", "<leader>gS", function() Snacks.picker.git_stash() end, opts)

opts.desc = "Git Diff (Hunks)" 
set("n", "<leader>gd", function() Snacks.picker.git_diff() end, opts)

opts.desc = "Git Log File" 
set("n", "<leader>gf", function() Snacks.picker.git_log_file() end, opts)

opts.desc = "Goto Definition" 
set("n", "gd", function() Snacks.picker.lsp_definitions() end, opts)

opts.desc = "Goto Declaration" 
set("n", "gD", function() Snacks.picker.lsp_declarations() end, opts)

opts.desc = "References" 
set("n", "gr", function() Snacks.picker.lsp_references() end, opts)

opts.desc = "Goto Implementation" 
set("n", "gI", function() Snacks.picker.lsp_implementations() end, opts)

opts.desc = "Goto T[y]pe Definition" 
set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, opts)

opts.desc = "LSP Symbols" 
set("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, opts)

opts.desc = "LSP Workspace Symbols" 
set("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, opts)

opts.desc = "LazyGit" 
set("n", "<leader>lg", function() Snacks.lazygit() end, opts)

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
set("i", "ii", "<ESC>", opts )

-- oil
set("n", "-", "<cmd>lua require('oil').open_float()<CR>", { noremap = true, silent = true })

--visual studio
set("n", "<leader>vs", "<cmd>!devenv /edit %<cr>", { desc = "Edit file in Visual Studio", noremap = true, silent = true })

-- dotnet format
set({ "v", "n"}, "<leader>=", "<cmd>!dotnet format whitespace<cr>", { desc = "Format file ", noremap = true, silent = true })

-- obsidian
set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open note in Obsidian", noremap = true, silent = true})
set("n", "<leader>od", "<cmd>ObsidianToday<CR>", { desc = "Open todays daily note", noremap = true, silent = true})
set("n", "<leader>ot", "<cmd>ObsidianTags<CR>", { desc = "List tags", noremap = true, silent = true})
set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Obsidian search", noremap = true, silent = true})
