return {
	"folke/snacks.nvim",
	enabled = true,
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		picker = {},
		input = {},
		notifier = {},
	},
	keys = {
		-- Top Pickers & Explorer
		{ "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
		{ "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
		{ "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
		-- find
		{ "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
		-- git
		{ "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
		{ "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
		{ "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
		-- { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
		{ "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
		{ "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
		{ "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
		-- { "<leader>gtl", function() Snacks.lazygit() end, desc = "Open LazyGit" },
		-- Grep
		{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
		{ "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
		{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
		-- search
		{ '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
		{ '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
		{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
		{ "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
		{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
		{ "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
		{ "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
		{ "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
		{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
		{ "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
		{ "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
		{ "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
		{ "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
		-- lsp
		{ "<leader>lr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
		-- Custom
		{
			"<leader>ti",
			function()
				Snacks.picker.grep_word({
					title = "Tasks",
					prompt = " ",
					search = "^\\s*- \\[ \\].*todo",
					regex = true,
					live = false,
					matcher = { fuzzy = false, filename_bonus = false, file_pos = false },
					preview = false,
					dirs = { vim.fn.getcwd() },
					args = { "--no-ignore" },
					-- on_show = function()
					-- 	vim.cmd.stopinsert()
					-- end,
					finder = "grep",
					format = function(item)
						return {
							{ item.line, "Normal"}
						}
					end,
					show_empty = true,
					supports_live = false,
					layout = {
						preset = "ivy",
						preview = false,
					},
				})
			end,
			desc = "Search for incomplete tasks",
		},
		{
			"<leader>tc",
			function()
				Snacks.picker.grep({
					title = "Completed tasks",
					prompt = " ",
					search = "^\\s*- \\[x\\].*todo",
					regex = true,
					live = false,
					matcher = { fuzzy = false, filename_bonus = true},
					dirs = { vim.fn.getcwd() },
					args = { "--no-ignore" },
					-- on_show = function()
					-- 	vim.cmd.stopinsert()
					-- end,
					finder = "grep",
					format = function(item)
						return {
							{ item.line, "Normal"}
						}
					end,
					show_empty = true,
					supports_live = false,
					layout = {
						preset = "ivy",
						preview = false,
					},
				})
			end,
			desc = "Search for complete tasks",
		},
		{
			"<leader>pr",
			function ()
				Snacks.picker.git_branches({
					title = "Select branch to diff",
					layout = {
						preset = "ivy",
						preview = false
					},
					win = {},
					confirm = function (picker, item)
						picker:close()
						if item then
							vim.cmd("DiffviewOpen origin/" .. item.branch .. "... --imply-local")
						end
					end
				})
			end
		}
	},
}
