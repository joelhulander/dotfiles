local config = require("config").plugins

return {
	'saghen/blink.cmp',
	enabled = config.blink ~= false,
	dependencies = { 'rafamadriz/friendly-snippets' },
	version = '1.*',
}
