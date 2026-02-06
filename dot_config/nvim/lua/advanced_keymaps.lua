local funcs = require("functions")

local function format_path(pattern, variables)
    return pattern:gsub("{([%w_]+)}", function(key)
        return variables[key] or ("{" .. key .. "}")
    end)
end

local function get_date_variables()
    return {
        year = os.date("%Y"),
        month_num = os.date("%m"),
        month_name = os.date("%B"),
        date = os.date("%Y-%m-%d"),
    }
end

-- Create task or checkbox
vim.keymap.set({ "n", "i" }, "<C-t>", function()
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

local set = vim.keymap.set
local opts = { noremap = true, silent = true }

opts.desc = "Create note with template"
set('n', '<leader>on', function()
    local templates = vim.g.personal_settings.obsidian.templates.note_templates

    if not templates or #templates == 0 then
        vim.notify("No templates configured", vim.log.levels.WARN)
        return
    end

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

            local prompt_text = chosen.prompt or ("Enter " .. chosen.name:lower() .. " name")

            vim.ui.input({ prompt = prompt_text .. ": " }, function(input)
                if not input or input == "" then
                    vim.notify("Operation cancelled", vim.log.levels.INFO)
                    return
                end

                local vars = get_date_variables()
                vars.folder = chosen.folder
                vars.input = input

                local path_pattern = chosen.path_pattern or "{folder}/{input}.md"
                vim.notify("Path pattern: " .. path_pattern, vim.log.levels.INFO)
                local path = format_path(path_pattern, vars)
                vim.notify("Path: " .. path, vim.log.levels.INFO)

                local folder_path = vim.fn.fnamemodify(path, ":h")
                vim.notify("Folder path: " .. folder_path, vim.log.levels.INFO)
                local filename = vim.fn.fnamemodify(path, ":t")
                vim.notify("Filename: " .. filename, vim.log.levels.INFO)

                funcs.create_note(filename, chosen.template, folder_path)
                vim.fn.rename(vim.api.nvim_buf_get_name(0), path)
                vim.cmd("e " .. path)
            end)
        end)
end, opts)

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
            funcs.change_project(selected_name)
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
    if counter ~= 0 and counter % 6 == 0 then
        leader = leader .. ","
        counter = 0
    end
    counter = counter + 1
    opts.desc = "Switch to workspace: " .. v.name
    set("n", leader .. counter, function()
        funcs.change_project(v.name)
    end, opts)
end

opts.desc = "List worktrees"
set('n', '<leader>fw', function()
    local worktrees = funcs.get_worktrees()

    if #worktrees == 0 then
        return
    end

    if #worktrees == 1 then
        vim.notify("Already in worktree", vim.log.levels.INFO)
        return
    end

    local options = {}
    for i, t in ipairs(worktrees) do
        local display = "🌿 " .. t.name
        options[i] = {
            display = display,
            name = t.name,
            path = t.path
        }
    end

    vim.ui.select(options, {
        prompt = "Choose a worktree",
        format_item = function(item)
            return type(item) == "table" and item.display or item
        end,
    }, function(selected_worktree)
            if not selected_worktree then return end

            funcs.switch_to_worktree(selected_worktree)
        end)
end, opts)

