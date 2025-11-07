return {
    'numToStr/Comment.nvim',
	enabled = true,
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		require('Comment').setup {}
	end,
}
