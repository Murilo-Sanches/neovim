return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		require("dapui").setup()
		require("dap-go").setup()
		local wk = require("which-key")

		local dap, dapui = require("dap"), require("dapui")

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		wk.add({
			{ "<leader>d", group = "Debugger" },
			{ "<leader>dt", ":DapToggleBreakpoint<CR>", desc = "Toggle Breakpoint" },
			{ "<leader>dc", ":DapContinue<CR>", desc = "Continue" },
			{ "<leader>dx", ":DapTerminate<CR>", desc = "Terminate" },
			{ "<leader>do", ":DapStepOver<CR>", desc = "Step Over" },
		})
	end,
}
