local M = {}

function M.create_note(filename, chosen_template, chosen_folder)
    local client = require("obsidian")
    local note = client.Note.create({
        id = filename,
        template = chosen_template .. ".md",
        dir = chosen_folder,
        should_write = true,
        verbatim = true
    })

    if note then
        -- note.open()
        client.Note.open(chosen_folder .. "/" .. filename, { sync = true })
    else
        vim.notify("Failed to create note: " .. chosen_folder .. "/" .. filename, vim.log.levels.ERROR)
    end
end

function M.get_nested_templates(name, callback)
    local templates = vim.g.personal_settings.obsidian.templates.note_templates

    local options = {}
    for _, t in ipairs(templates) do
        if t.name == name then
            for n, nt in ipairs(t.nested_templates) do
                options[n] = nt.name
            end
        end
    end

    vim.ui.select(options, {
        prompt = "Choose travel template",
        format_item = function(item) return item end,
    }, function (selected)
            if not selected then
                callback(nil)
                return
            end

            -- Find the selected template
            for _, t in ipairs(templates) do
                if t.name == name then
                    for _, nt in ipairs(t.nested_templates) do
                        if nt.name == selected then
                            callback(nt)
                            break
                        end
                    end
                end
            end
        end)
end

local function get_git_common_dir()
    local result = vim.system({'git', 'rev-parse', '--git-common-dir'}, {
        text = true,
        timeout = 1000,
    }):wait()

    if result.code == 0 and result.stdout then
        -- Normalize the path (remove trailing whitespace, resolve to absolute)
        local common_dir = result.stdout:gsub("%s+$", "")
        return vim.fn.fnamemodify(common_dir, ":p")
    end
    return nil
end


function M.change_project(project)
    if not project then return end

    local projects = vim.g.personal_settings.projects
    local chosen
    for _, t in ipairs(projects) do
        if t.name == project then
            chosen = t
            break
        end
    end

    if not chosen then return end
    vim.api.nvim_set_current_dir(chosen.path)
    vim.notify("Changing workspace to " .. chosen.name,  vim.log.levels.INFO)

    -- Check if this project has a remembered worktree
    local common_dir = get_git_common_dir()
    local actual_path = chosen.path
    if common_dir and _G.last_worktree_paths[common_dir] then
        local last_wt_path = _G.last_worktree_paths[common_dir]
        if vim.fn.isdirectory(last_wt_path) == 1 then
            vim.api.nvim_set_current_dir(last_wt_path)
            actual_path = last_wt_path
            vim.notify("Restored worktree: " .. vim.fn.fnamemodify(last_wt_path, ":t"), vim.log.levels.INFO)
        end
    end

    local last_buffer = _G.last_project_buffers[actual_path]
    if not _G.project_terminals[actual_path] then
        _G.project_terminals[actual_path] = {
            buf = nil,
            win = nil,
            is_open = false
        }
    end

    if last_buffer and vim.fn.bufexists(last_buffer) == 1 then
        vim.cmd("buffer " .. last_buffer)
    else
        require('oil').open(actual_path)
    end
end

local function is_inside_worktree()
    local git_result = vim.system({'git', 'rev-parse', '--is-inside-work-tree'}, {
        timeout = 1000,
        text = true
    }):wait()

    return git_result.stdout:match("true")
end

function M.get_worktrees()

    if not is_inside_worktree() then
        vim.notify("No worktrees found or not in a git repository", vim.log.levels.WARN)
        return {}
    end

    local result = vim.system({'git', 'worktree', 'list'}, {
        text = true,
        timeout = 5000,
    }):wait()

    if result.code ~= 0 then
        if result.code ~= 128 then
            vim.notify("Git worktree command failed: " .. (result.stderr or ""), vim.log.levels.WARN)
        end
        return {}
    end

    local worktrees = {}

    for line in result.stdout:gmatch("[^\r\n]+") do
        line = line:gsub("^%s+", ""):gsub("%s+$", "")

        if line ~= "" then
            -- Skip bare repository entries
            if not line:match("%(bare%)") then
                -- Split by whitespace
                local parts = {}
                for part in line:gmatch("%S+") do
                    table.insert(parts, part)
                end

                if #parts >= 2 then
                    local path = parts[1]

                    -- Look for branch in brackets [branch_name]
                    local branch = line:match("%[(.-)%]")

                    if path and branch then
                        local folder_name = vim.fn.fnamemodify(path, ":t")
                        local name = "wt:" .. folder_name .. " (" .. branch .. ")"

                        table.insert(worktrees, {
                            name = name,
                            path = path,
                            branch = branch
                        })
                    end
                end
            end
        end
    end

    return worktrees
end

function M.switch_to_worktree(wt)
    vim.notify("Switching to " .. wt.name, vim.log.levels.INFO)
    vim.api.nvim_set_current_dir(wt.path)

    -- Track this worktree as the last used for this repo
    local common_dir = get_git_common_dir()
    if common_dir then
        _G.last_worktree_paths[common_dir] = wt.path
    end

    require('oil').open(wt.path)
end

return M
