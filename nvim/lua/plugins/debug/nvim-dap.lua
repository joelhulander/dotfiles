local config = require("config").plugins

return {
	"mfussenegger/nvim-dap",
	enabled = config.nvim_dap ~= false,
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- ===== Logging & Virtual Text =====
		vim.g.dap_log_level = 'TRACE'
		require("nvim-dap-virtual-text").setup()

		-- ===== dap-ui setup =====
		dapui.setup()
		dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
		dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
		dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

		-- ===== Signs =====
		vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = 'DapBreakpointSign', linehl = '', numhl = '' })
		vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })

		dap.defaults.fallback.timeout = 10000

		-- ===== C# configuration (CoreCLR) =====
		dap.adapters.coreclr = {
			type = "executable",
			command = 'netcoredbg.cmd',
			args = { "--interpreter=vscode" },
			options = { detached = false, cwd = vim.fn.getcwd() }
		}

		dap.configurations.cs = {
			{
				type = "coreclr",
				name = ".NET Core Launch (web)",
				request = "launch",
				program = function()
					return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '\\', 'file')
				end,
				serverReadyAction = {
					action = "openExternally",
					pattern = "\\bNow listening on:\\s+(https?://\\S+)"
				},
				stopAtEntry = false,
				console = "integratedTerminal",
			},
			{
				type = "coreclr",
				name = ".NET Core Attach",
				request = "attach",
				processId = function() return require('dap.utils').pick_process() end,
				justMyCode = false,
			}
		}

		-- ===== Rust configuration (codelldb) =====
		dap.adapters.codelldb = {
			type = 'server',
			port = "${port}",
			executable = {
				command = "codelldb",
				args = { "--port", "${port}" },
				detached = false,
			}
		}

		dap.configurations.rust = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
				end,
				cwd = '${workspaceFolder}',
				stopOnEntry = false,
				args = {},
				setupCommands = {
					{
						text = '-enable-pretty-printing',
						description = 'enable pretty printing',
						ignoreFailures = false
					}
				}
			},
			{
				name = "Attach to process",
				type = "codelldb",
				request = "attach",
				pid = require('dap.utils').pick_process,
				cwd = '${workspaceFolder}',
				setupCommands = {
					{
						text = '--enable-pretty-printing',
						description = 'enable pretty printing',
						ignoreFailures = false
					}
				}
			}
		}

		-- ===== Keymaps for debugging =====
		local map_opts = { noremap = true, silent = true }
		local map = vim.keymap.set

		-- DAP core controls
		map("n", "<leader>dc", dap.continue, { desc = "Continue/Run", unpack(map_opts) })
		map("n", "<leader>dn", dap.step_over, { desc = "Step Over", unpack(map_opts) })
		map("n", "<leader>di", dap.step_into, { desc = "Step Into", unpack(map_opts) })
		map("n", "<leader>do", dap.step_out, { desc = "Step Out", unpack(map_opts) })

		-- Breakpoints
		map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint", unpack(map_opts) })
		map("n", "<leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Conditional Breakpoint", unpack(map_opts) })
		map("n", "<leader>dl", function()
			dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end, { desc = "Log Point", unpack(map_opts) })

		-- REPL and UI
		map("n", "<leader>dR", dap.repl.open, { desc = "Open REPL", unpack(map_opts) })
		map("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI", unpack(map_opts) })

		-- Run last debug session
		map("n", "<leader>dr", dap.run_last, { desc = "Run Last Debug Session", unpack(map_opts) })
	end,
}
