local config = require("config").plugins

return {
	'saghen/blink.cmp',
	enabled = config.blink ~= false,
	dependencies = { 'rafamadriz/friendly-snippets' },
	version = '1.*',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		completion = {
			documentation = {
				auto_show = true
			}
		}
	}
}
