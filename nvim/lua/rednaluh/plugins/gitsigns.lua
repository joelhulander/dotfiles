return {
	'lewis6991/gitsigns.nvim',
	event = { "BufReadPre", "BufNewFile"},
	opts = {
		signs = {
			add          = { text = '┃' },
			change       = { text = '┃' },
			delete       = { text = '_' },
			topdelete    = { text = '‾' },
			changedelete = { text = '~' },
			untracked    = { text = '┆' },
		},
		signs_staged = {
			add          = { text = '┃' },
			change       = { text = '┃' },
			delete       = { text = '_' },
			topdelete    = { text = '‾' },
			changedelete = { text = '~' },
			untracked    = { text = '┆' },
		},
		on_attach = function (bufnr)
			local gitsigns = require('gitsigns')

			-- Actions
			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Actions
			local opts = { noremap = true, silent = true }

			-- Navigation
			opts.desc = "Go to next hunk"
			map('n', ']c', function()
				if vim.wo.diff then
					vim.cmd.normal({']c', bang = true})
				else
					gitsigns.nav_hunk('next', { target = 'all' } )
				end
			end, opts)

			opts.desc = "Go to previous hunk"
			map('n', '[c', function()
				if vim.wo.diff then
					vim.cmd.normal({'[c', bang = true})
				else
					gitsigns.nav_hunk('prev', { target = 'all' } )
				end
			end, opts)


			opts.desc = "Stage hunk"
			map('n', '<leader>gs', gitsigns.stage_hunk, opts)
			opts.desc = "Reset hunk"
			map('n', '<leader>gr', gitsigns.reset_hunk, opts)
			opts.desc = "Stage hunk"
			map('v', '<leader>gs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, opts)
			opts.desc = "Reset hunk"
			map('v', '<leader>gr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, opts)
			opts.desc = "Stage buffer"
			map('n', '<leader>gS', gitsigns.stage_buffer, opts)
			opts.desc = "Undo stage hunk"
			map('n', '<leader>gu', gitsigns.undo_stage_hunk, opts)
			opts.desc = "Reset buffer"
			map('n', '<leader>gR', gitsigns.reset_buffer, opts)
			opts.desc = "Preview hunk"
			map('n', '<leader>gp', gitsigns.preview_hunk, opts)
			opts.desc = "Blame line"
			map('n', '<leader>gb', function() gitsigns.blame_line{full=true} end, opts)
			opts.desc = "Open git blame"
			map('n', '<leader>gB', function() gitsigns.blame() end, opts)
			opts.desc = "Toggle current line blame"
			map('n', '<leader>gtb', gitsigns.toggle_current_line_blame, opts)
			opts.desc = "Diff this"
			map('n', '<leader>gd', gitsigns.diffthis, opts)
			opts.desc = "Toggle deleted"
			map('n', '<leader>gtd', gitsigns.toggle_deleted, opts)

		end
	},
}
