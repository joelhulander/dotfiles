local config = require("config").plugins

return {
	'MeanderingProgrammer/render-markdown.nvim',
	enabled = config.render_markdown ~= false,
	opts = {},
	dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
}
