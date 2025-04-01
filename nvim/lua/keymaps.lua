vim.g.mapleader = " "

local set = vim.keymap.set
local opts = { noremap = true, silent = true }

set("n", "<leader>a", ":keepjumps normal! ggVG<cr>", { desc = "Select all", noremap = true })
set("n", "<Esc>", "<cmd>nohlsearch<CR>")
set("x", "<leader>p", "\"_dP", opts)
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
set({ "n", "v" }, "<C-d>", "<C-d>zz", { noremap = true })
set({ "n", "v" }, "<C-u>", "<C-u>zz", { noremap = true })
set({ "n", "v" }, "n", "nzz", { noremap = true })
set({ "n", "v" }, "N", "Nzz", { noremap = true })

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
set("n", "<leader>ft", "<cmd>ObsidianTags<CR>", { desc = "List tags", noremap = true, silent = true})
set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Obsidian search", noremap = true, silent = true})
set("n", "<leader>oti", "<cmd>ObsidianTemplate<CR>", { desc = "Insert template", noremap = true, silent = true})
set("n", "<leader>otn", "<cmd>ObsidianNewFromTemplate<CR>", { desc = "New from template", noremap = true, silent = true})

-- mini.nvim
set("n", "<leader>go", "<cmd>lua MiniDiff.toggle_overlay()<CR>", { desc = "Toggle overlay", noremap = true, silent = true})
set("n", "<leader>gtt", "<cmd>lua MiniDiff.toggle()<CR>", { desc = "Toggle mini diff", noremap = true, silent = true})
set("n", "<leader>gD", "<cmd>Git diff<CR>", { desc = "Mini Diff", noremap = true, silent = true})
set("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Commit", noremap = true, silent = true})
set("n", "<leader>gp", "<cmd>Git pull<CR>", { desc = "Pull", noremap = true, silent = true})
set("n", "<leader>gP", "<cmd>Git push<CR>", { desc = "Push", noremap = true, silent = true})
set("n", "<leader>gs", "<cmd>Git status<CR>", { desc = "Status", noremap = true, silent = true})
set("n", "<leader>gl", "<cmd>Git log<CR>", { desc = "Log", noremap = true, silent = true})

-- advanced

-- Create task or checkbox
vim.keymap.set({ "n", "i" }, "<C-l>", function()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local row, _ = cursor_pos[1], cursor_pos[2]
	local line = vim.api.nvim_get_current_line()
	local mode = vim.api.nvim_get_mode().mode

	if line:match("^%s*$") then
		local final_line = "- [ ] "
		vim.api.nvim_set_current_line(final_line)
		vim.api.nvim_win_set_cursor(0, { row, 6 })
		if mode == "i" then
			vim.cmd("startinsert")
		end
		return
	end

	local indent, checkbox, post_space, text = line:match("^(%s*)(-%s+%[[ x]%])(%s*)(.*)$")
	if indent and checkbox then
		local col = #indent + #checkbox + #post_space

		if post_space == "" then
			local final_line = indent .. checkbox .. " " .. text
			vim.api.nvim_set_current_line(final_line)
			col = col + 1 -- Account for the added space
		end

		vim.api.nvim_win_set_cursor(0, { row, col })

		if mode == "i" then
			vim.cmd("startinsert")
		end
		return
	end

	local bullet, bullet_text = line:match("^([%s]*[-*]%s+)(.*)$")
	if bullet then
		local final_line = bullet .. "[ ] " .. bullet_text

		vim.api.nvim_set_current_line(final_line)

		local bullet_len = #bullet

		vim.api.nvim_win_set_cursor(0, { row, bullet_len + 4 })
		if mode == "i" then
			vim.cmd("startinsert")
		end
		return
	end

	local final_line = "- [ ] " .. line
	vim.api.nvim_set_current_line(final_line)
	vim.api.nvim_win_set_cursor(0, { row, 6 })
	if mode == "i" then
		vim.cmd("startinsert")
	end
end, { desc = "Convert bullet to a task or insert new task bullet" })

-- toggle task
vim.keymap.set("n", "<leader>tx", function()
	local label_done = "done:"
	local timestamp = os.date("%Y-%m-%d %H:%M")
	local tasks_heading = "## Completed tasks"

	vim.cmd("mkview")
	local api = vim.api
	local buf = api.nvim_get_current_buf()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local start_line = cursor_pos[1] - 1
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	local total_lines = #lines

	if start_line >= total_lines then
		vim.cmd("loadview")
		return
	end
	------------------------------------------------------------------------------
	-- (A) Move upwards to find the bullet line (if user is somewhere in the chunk)
	------------------------------------------------------------------------------
	while start_line > 0 do
		local line_text = lines[start_line + 1]
		-- Stop if we find a blank line or a bullet line
		if line_text == "" or line_text:match("^%s*%-") then
			break
		end
		start_line = start_line - 1
	end

	if lines[start_line + 1] == "" and start_line < (total_lines - 1) then
		start_line = start_line + 1
	end
	------------------------------------------------------------------------------
	-- (B) Validate that it's actually a task bullet, i.e. '- [ ]' or '- [x]'
	------------------------------------------------------------------------------
	local bullet_line = lines[start_line + 1]
	if not bullet_line:match("^%s*%- %[[x ]%]") then
		print("Not a task bullet: no action taken.")
		vim.cmd("loadview")
		return
	end
	------------------------------------------------------------------------------
	-- 1. Identify the chunk boundaries
	------------------------------------------------------------------------------
	local chunk_start = start_line
	local chunk_end = start_line
	while chunk_end + 1 < total_lines do
		local next_line = lines[chunk_end + 2]
		if next_line == "" or next_line:match("^%s*%-") then
			break
		end
		chunk_end = chunk_end + 1
	end

	local chunk = {}
	for i = chunk_start, chunk_end do
		table.insert(chunk, lines[i + 1])
	end

	------------------------------------------------------------------------------
	-- 2. Check if chunk has [done: ...] or [untoggled], then transform them
	------------------------------------------------------------------------------

	local has_done_index = nil
	local has_untoggled_index = nil
	for i, line in ipairs(chunk) do
		chunk[i] = line:gsub("%[done:([^%]]+)%]", "`" .. label_done .. "%1`")
		chunk[i] = chunk[i]:gsub("%[untoggled%]", "`untoggled`")

		if chunk[i]:match("`" .. label_done .. ".-`") then
			has_done_index = i
			break
		end
	end
	if not has_done_index then
		for i, line in ipairs(chunk) do
			if line:match("`untoggled`") then
				has_untoggled_index = i
				break
			end
		end
	end

	------------------------------------------------------------------------------
	-- 3. Helpers to toggle bullet
	------------------------------------------------------------------------------
	
	local function bulletToX(line)
		return line:gsub("^(%s*%- )%[%s*%]", "%1[x]")
	end

	local function bulletToBlank(line)
		return line:gsub("^(%s*%- )%[x%]", "%1[ ]")
	end
	------------------------------------------------------------------------------
	-- 4. Insert or remove label *after* the bracket
	------------------------------------------------------------------------------
	local function insertLabelAfterBracket(line, label)
		local prefix = line:match("^(%s*%- %[[x ]%])")
		if not prefix then
			return line
		end
		local rest = line:sub(#prefix + 1)
		return prefix .. " " .. label .. rest
	end
	local function removeLabel(line)
		-- If there's a label (like `` `done: ...` `` or `` `untoggled` ``) right after
		-- '- [x]' or '- [ ]', remove it
		return line:gsub("^(%s*%- %[[x ]%])%s+`.-`", "%1")
	end
	------------------------------------------------------------------------------
	-- 5. Update the buffer with new chunk lines (in place)
	------------------------------------------------------------------------------
	local function updateBufferWithChunk(new_chunk)
		for idx = chunk_start, chunk_end do
			lines[idx + 1] = new_chunk[idx - chunk_start + 1]
		end
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	end
	------------------------------------------------------------------------------
	-- 6. Main toggle logic
	------------------------------------------------------------------------------
	if has_done_index then
		chunk[has_done_index] = removeLabel(chunk[has_done_index]):gsub("`" .. label_done .. ".-`", "`untoggled`")
		chunk[1] = bulletToBlank(chunk[1])
		chunk[1] = removeLabel(chunk[1])
		chunk[1] = insertLabelAfterBracket(chunk[1], "`untoggled`")
		updateBufferWithChunk(chunk)
		vim.notify("Untoggled", vim.log.levels.INFO)
	elseif has_untoggled_index then
		chunk[has_untoggled_index] =
		removeLabel(chunk[has_untoggled_index]):gsub("`untoggled`", "`" .. label_done .. " " .. timestamp .. "`")
		chunk[1] = bulletToX(chunk[1])
		chunk[1] = removeLabel(chunk[1])
		chunk[1] = insertLabelAfterBracket(chunk[1], "`" .. label_done .. " " .. timestamp .. "`")
		updateBufferWithChunk(chunk)
		vim.notify("Completed", vim.log.levels.INFO)
	else
		local win = api.nvim_get_current_win()
		local view = api.nvim_win_call(win, function()
			return vim.fn.winsaveview()
		end)

		chunk[1] = bulletToX(chunk[1])
		chunk[1] = insertLabelAfterBracket(chunk[1], "`" .. label_done .. " " .. timestamp .. "`")

		for i = chunk_end, chunk_start, -1 do
			table.remove(lines, i + 1)
		end

		local heading_index = nil
		for i, line in ipairs(lines) do
			if line:match("^" .. tasks_heading) then
				heading_index = i
				break
			end
		end
		if heading_index then
			local has_blank_line = (heading_index + 1 <= #lines and lines[heading_index + 1] == "")

			if not has_blank_line then
				table.insert(lines, heading_index + 1, "")
				heading_index = heading_index + 1
			end

			for _, cLine in ipairs(chunk) do
				table.insert(lines, heading_index + 1, cLine)
				heading_index = heading_index + 1
			end
			local after_last_item = heading_index + 1
			if lines[after_last_item] == "" then
				table.remove(lines, after_last_item)
			end
		else
			table.insert(lines, tasks_heading)
			table.insert(lines, "")
			for _, cLine in ipairs(chunk) do
				table.insert(lines, cLine)
			end
			local after_last_item = #lines + 1
			if lines[after_last_item] == "" then
				table.remove(lines, after_last_item)
			end
		end
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
		vim.notify("Completed", vim.log.levels.INFO)
		api.nvim_win_call(win, function()
			vim.fn.winrestview(view)
		end)
	end
	vim.cmd("silent update")
	vim.cmd("loadview")
end, { desc = "[P]Toggle task and move it to 'done'" })
