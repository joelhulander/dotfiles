local config = require("config").plugins

return {
	"mfussenegger/nvim-dap",
	enabled = config.nvim_dap ~= false,
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
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

		vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
		vim.fn.sign_define('DapStopped', {text='▶️', texthl='', linehl='', numhl=''})

		dap.adapters.coreclr = {
			type = "executable",
			command = 'C:/Users/JoelHulander/AppData/Local/nvim-data/mason/bin/netcoredbg.cmd',
			args = { "--interpreter=vscode" },
		}

		dap.configurations.cs = {
			{
				type = "coreclr",
				name = ".NET Core Launch (web)",
				request = "launch",
				-- preLaunchTask = "build",
				-- cwd = "${workspaceFolder}/SA",
				program = function()
					return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/', 'file')
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
			}
		}

		dapui.setup()
	end,
}
