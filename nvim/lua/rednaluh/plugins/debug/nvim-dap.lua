return {
	"mfussenegger/nvim-dap",
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

		-- dap.adapters.coreclr = {
		-- 	type = "executable",
		-- 	command = "C:/Users/JHU02/AppData/Local/nvim-data/mason/bin/netcoredbg.cmd",
		-- 	args = { "--interpreter=vscode" },
		-- }
		--
		-- dap.configurations.cs = {
		-- 	{
		-- 		type = "coreclr",
		-- 		name = "Attach to process",
		-- 		request = "attach",
		-- 		processId = require("dap.utils").pick_process,
		-- 	},
		-- }

		dapui.setup()
	end,
}
