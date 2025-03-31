local config = require("config").plugins

return {
    "tris203/hawtkeys.nvim",
	enabled = config.hawtkeys ~= false,
    config = true,
	event = { "BufReadPre", "BufNewFile" },
}
