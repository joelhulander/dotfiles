local config = require("config").plugins

return {
	"mfussenegger/nvim-dap",
	enabled = config.nvim_dap ~= false,
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		vim.g.dap_log_level = 'TRACE'

		require("nvim-dap-virtual-text").setup()

		local dap, dapui = require("dap"), require("dapui")

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='DapBreakpointSign', linehl='', numhl=''})
		vim.fn.sign_define('DapStopped', {text='▶️', texthl='', linehl='', numhl=''})

		dap.defaults.fallback.timeout = 10000

		dap.adapters.coreclr = {
			type = "executable",
			command = 'netcoredbg.cmd',
			args = { "--interpreter=vscode" },
			options = {
				detached = false,
				cwd = vim.fn.getcwd()
			}
		}

		dap.configurations.cs = {
			{
				type = "coreclr",
				name = ".NET Core Launch (web)",
				request = "launch",
				-- preLaunchTask = "build",
				-- cwd = "${workspaceFolder}/SA",
				program = function()
					return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '\\', 'file')
				end,
				serverReadyAction = {
					action = "openExternally",
					pattern = "\\bNow listening on:\\s+(https?://\\S+)"
				},
				stopAtEntry = false,
				console = "integratedTerminal",
				-- env = {
				-- 	aspnetcore_environment = "Development"
				-- },
			},
			{
				type = "coreclr",
				name = ".NET Core Attach",
				request = "attach",
				processId = function()
					return require('dap.utils').pick_process()
				end,
				justMyCode = false,
			}
		}

		dap.adapters.cppdbg = {
			id = 'cppdbg',
			type = 'executable',
			command = 'OpenDebugAD7'
		}

		dap.configurations.rust = {
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function ()
					return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				end,
				cwd = '${workspaceFolder}',
				stopAtEntry = true,
				setupCommands = {
					{
						text = '-enable-pretty-printing',
						description = 'enable pretty printing',
						ignoreFailures = false
					}
				}
			},
			{
				name = 'Attach to gdbserver :1234',
				type = 'cppdbg',
				request = 'launch',
				MIMode = 'gdb',
				miDebuggerServerAddress = 'localhost:1234',
				miDebuggerPath = '/usr/bin/gdb',
				cwd = '${workspaceFolder}',
				program = function ()
					return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				end,
				setupCommands = {
					{
						text = '-enable-pretty-printing',
						description = 'enable pretty printing',
						ignoreFailures = false
					}
				}
			}
		}

		dapui.setup()
	end,
}
