return {
	"mfussenegger/nvim-dap",
	"mxsdev/nvim-dap-vscode-js",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio", -- requiered for dap-ui
		"leoluz/nvim-dap-go",
		"microsoft/vscode-js-debug",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dapVsCodeJS = require("dap-vscode-js")

		require("dapui").setup()
		-- config debugger for GoLang
		require("dap-go").setup()

		-- Setup nvim-dap-vscode-js
		dapVsCodeJS.setup({
			debugger_path = vim.fn.stdpath("data") .. "/vscode-js-debug",
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge" },
			-- node_path = "/opt/homebrew/bin/node",
		})

		-- Define the debugger adapter for Node.js
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = { vim.fn.stdpath("data") .. "/vscode-js-debug/out/src/vsDebugServer.js", "${port}" },
			},
		}

		-- JavaScript and TypeScript Debugging Configurations
		dap.configurations.javascript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch JS File",
				program = "${file}",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				console = "integratedTerminal",
				skipFiles = { "<node_internals>/**" },
			},
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach to Process",
				processId = require("dap.utils").pick_process,
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				skipFiles = { "<node_internals>/**" },
			},
		}

		dap.configurations.typescript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch TS File",
				program = "${file}",
				cwd = vim.fn.getcwd(),
				runtimeExecutable = "node",
				runtimeArgs = { "--require", "ts-node/register" },
				sourceMaps = true,
				protocol = "inspector",
				console = "integratedTerminal",
				skipFiles = { "<node_internals>/**" },
			},
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach to Process",
				processId = require("dap.utils").pick_process,
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				skipFiles = { "<node_internals>/**" },
			},
		}

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

		vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<Leader>dc", dap.continue, {})

		-- VSCode-like keybindings for debugging
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Continue/Start Debugging" })
		vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
		vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
		vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step Out" })
		-- vim.keymap.set("n", "<Leader>B", function()
		-- 	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		-- end, { desc = "Set Conditional Breakpoint" })
		vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open Debug Console" })
		vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Run Last Debug Configuration" })
	end,
}
