return {
	"krivahtoo/silicon.nvim",
	build = "./install.sh",
	config = function ()
		local silicon = require('silicon')

		silicon.setup({ font = 'Hack Nerd Font=28',
			theme = 'Nord',
			output = {
				clipboard = true,
				format = "silicon_[year][month][day]_[hour][minute][second].png",
			},
			line_number = true,
			window_title = function()
				return vim.fn.fnamemodify(vim.fn.bufname(vim.fn.bufnr()), ':~:.')
			end,
			background = '#a8a7ca',
			shadow = {
				blur_radius = 0.0,
				offset_x = 0,
				offset_y = 0,
				color = '#555'
			},
			round_corner = true,
		})

		local keymap = vim.keymap
		local opts = { noremap = true, silent = true }

		opts.desc = 'Copy selection to clipboard as an image'
		keymap.set('v', '<leader>sc', ":'<,'>Silicon<cr>", opts)
	end
}
