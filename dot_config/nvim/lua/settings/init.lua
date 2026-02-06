local M = {}

function M.load()
    local defaults = require("settings.defaults")

    -- Try to load machine-specific settings
    local ok, machine = pcall(require, "settings.machine")
    if not ok then
        vim.notify(
            "Machine settings not found. Run 'chezmoi apply' to generate lua/settings/machine.lua",
            vim.log.levels.WARN
        )
        return defaults
    end

    return vim.tbl_deep_extend("force", defaults, machine)
end

return M
