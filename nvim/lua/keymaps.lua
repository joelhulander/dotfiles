vim.g.mapleader = " "

local set = vim.keymap.set
local opts = { noremap = true, silent = true }

set("n", "<leader>a", ":keepjumps normal! ggVG<cr>", { desc = "Select all", noremap = true })
set("n", "<Esc>", "<cmd>nohlsearch<CR>")
set("x", "<leader>pp", "\"_dP", opts)
set("i", "<C-c>", "<Esc>", opts)

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
set({ "n", "v" }, "<C-d>", "<C-d>zz", opts)
set({ "n", "v" }, "<C-u>", "<C-u>zz", opts)

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
opts.desc = "Open note in Obsidian"
set("n", "<leader>oo", "<cmd>Obsidian open<CR>", opts)
opts.desc = "Open todays daily note"
set("n", "<leader>od", "<cmd>Obsidian today<CR>", opts)
opts.desc = "List tags"
set("n", "<leader>ft", "<cmd>Obsidian tags<CR>", opts)
opts.desc = "Obsidian search"
set("n", "<leader>os", "<cmd>Obsidian search<CR>", opts)
opts.desc = "Insert template"
set("n", "<leader>oti", "<cmd>Obsidian template<CR>", opts)
opts.desc = "New from template"
set("n", "<leader>otn", "<cmd>Obsidian new_from_template<CR>", opts)
opts.desc = "Link note under selection"
set({ "n", "v" }, "<leader>ol", "<cmd>Obsidian link<CR>", opts)
opts.desc = "List backlinks to this note"
set("n", "<leader>ob", "<cmd>Obsidian backlinks<CR>", opts)

-- markdown preview
opts.desc = "Markdown preview toggle"
set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", opts)

-- mini.nvim
opts.desc = "Toggle overlay"
set("n", "<leader>go", "<cmd>lua MiniDiff.toggle_overlay()<CR>", opts)
opts.desc = "Toggle mini diff"
set("n", "<leader>gtt", "<cmd>lua MiniDiff.toggle()<CR>", opts)
opts.desc = "Mini Diff"
set("n", "<leader>gD", "<cmd>Git diff<CR>", opts)
opts.desc = "Commit"
set("n", "<leader>gc", "<cmd>Git commit<CR>", opts)
opts.desc = "Pull"
set("n", "<leader>gp", "<cmd>Git pull<CR>", opts)
opts.desc = "Push"
set("n", "<leader>gP", "<cmd>Git push<CR>", opts)
opts.desc = "Status"
set("n", "<leader>gs", "<cmd>Git status<CR>", opts)
opts.desc = "Log"
set("n", "<leader>gl", "<cmd>Git log<CR>", opts)
opts.desc = "Show at cursor"
set("n", "<leader>gC", "<cmd>lua MiniGit.show_at_cursor()<CR>", opts)

-- options
opts.desc = "Toggle relative line number"
set({'n', 'v'}, '<leader>ln', function ()
	vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, opts)
