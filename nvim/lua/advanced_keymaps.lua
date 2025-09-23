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
			if #lines > 0 and lines[#lines] ~= "" then
				table.insert(lines, "")
			end
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

local set= vim.keymap.set
local opts = { noremap = true, silent = true }

function Create_note(path, chosen_template)
	local client = require("obsidian")
	local note = client.Note.new({
		title = path,
		template = chosen_template .. ".md"
	})

	if note then
		client.Note.open(path, { sync = true })
		vim.notify("Created note: " .. path .. " with template: " .. chosen_template, vim.log.levels.INFO)
	else
		vim.notify("Failed to create note: " .. path, vim.log.levels.ERROR)
	end
end

opts.desc = "Create note with template"
set('n', '<leader>on', function()
	-- Define templates with names, template names, and destination folders
	local templates = {
		{ name = "Meeting", template = "Meeting", folder = "6 - Notes/Meetings" },
		{ name = "Note", template = "Note (nvim)", folder = "6 - Notes" },
	}

	local options = {}
	for i, t in ipairs(templates) do
		options[i] = t.name
	end

	vim.ui.select(options, {
		prompt = "Choose a Template",
		format_item = function(item) return item end,
	}, function(selected_name)
			if not selected_name then return end

			-- Find the selected template
			local chosen
			for _, t in ipairs(templates) do
				if t.name == selected_name then
					chosen = t
					break
				end
			end

			if not chosen then return end

			local year = os.date("%Y")
			local month_num = os.date("%m")
			local month_name = os.date("%B")
			local date_str = os.date("%Y-%m-%d")

			-- For Note Template, prompt for filename
			local path, filename

			if chosen.name == "Meeting" then
				-- Prompt for meeting name
				vim.ui.input({ prompt = "Enter meeting name: " }, function(input)
					if not input or input == "" then
						vim.notify("Operation cancelled", vim.log.levels.INFO)
						return
					end

					filename = input

					path = string.format("6 - Notes/Meetings/%s/%s-%s/%s-%s", year, month_num, month_name, date_str, filename .. ".md")

					Create_note(path, chosen.template)
					vim.fn.rename(vim.api.nvim_buf_get_name(0), path)
					vim.cmd("e " .. path)
				end)

			elseif chosen.name == "Note" then
				-- Prompt for note name
				vim.ui.input({ prompt = "Enter note name: " }, function(input)
					if not input or input == "" then
						vim.notify("Operation cancelled", vim.log.levels.INFO)
						return
					end

					filename = input
					path = chosen.folder .. "/" .. filename .. ".md"

					Create_note(path, chosen.template)
					vim.fn.rename(vim.api.nvim_buf_get_name(0), path)
					vim.cmd("e " .. path)
				end)
			end
		end)
end, opts)

function Change_project(project)
	if not project then return end

	local projects = vim.g.personal_settings.projects

	-- Find the selected project 
	local chosen
	for _, t in ipairs(projects) do
		if t.name == project then
			chosen = t
			break
		end
	end

	if not chosen then return end
	vim.api.nvim_set_current_dir(chosen.path)
	-- vim.notify("Changing CWD to " .. chosen.path,  vim.log.levels.INFO)
	vim.notify("Changing workspace to " .. chosen.name,  vim.log.levels.INFO)

	local last_buffer = _G.last_project_buffers[chosen.path]

	if last_buffer and vim.fn.bufexists(last_buffer) == 1 then
		vim.cmd("buffer " .. last_buffer)
	else
		vim.cmd("enew")
		-- vim.cmd("Oil")
	end
end

opts.desc = "List projects"
set('n', '<leader>fp', function()
	local projects = vim.g.personal_settings.projects

	local options = {}
	for i, t in ipairs(projects) do
		options[i] = t.name
	end

	vim.ui.select(options, {
		prompt = "Choose a project",
		format_item = function(item) return item end,
	}, function(selected_name)
			Change_project(selected_name)
		end)
end, opts)

opts.desc = "Insert current time"
set("n", "<leader>it", function()
	local time = vim.fn.strftime('%H:%M') .. ' - '
	vim.api.nvim_paste(time, false, -1)
	vim.cmd("startinsert!")
end, opts)

opts.desc = "Browser search"
set("n", "<leader>bs", function()
	local searchEngines = {
		{ name = "Google", url= "https://www.google.com/search?q=" },
		{ name = "DuckDuckGo", url = "https://duckduckgo.com?q=" },
		{ name = "Claude AI", url = "https://claude.ai/new?q=" },
	}

	local options = {}
	for i, t in ipairs(searchEngines) do
		options[i] = t.name
	end

	vim.ui.select(options, {
		prompt = "Choose search engine",
		format_item = function(item) return item end,
	}, function(selected)
			if not selected then return end

			local searchEngine
			for _, t in ipairs(searchEngines) do
				if t.name == selected then
					searchEngine = t
					break
				end
			end

			if not searchEngine then return end

			local url

			vim.ui.input({ prompt = "Search prompt" }, function(input)
				if not input or input == "" then
					vim.notify("Operation cancelled", vim.log.levels.INFO)
					return
				end

				url = string.format(searchEngine.url .. "%s", input)

				vim.ui.open(url)
			end)


		end)

end, opts)

local leader = ","
local counter = 0

for i,v in ipairs(vim.g.personal_settings.projects) do
	if counter ~= 0 and counter % 4 == 0 then
		leader = leader .. ","
		counter = 0
	end
	counter = counter + 1
	opts.desc = "Switch to workspace: " .. v.name
	set("n", leader .. counter, function()
		Change_project(v.name)
	end, opts)
end

