return {
	{
		"mfussenegger/nvim-dap",
		cmd = function()
			require("dap")
		end,
		init = function()
			-- DAP debugger with config for golang tests
			-- https://miguelcrespo.co/how-to-debug-like-a-pro-using-neovim
			vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
		end,
		config = function()
			-- the nvim-dap-ui is important so we can see the debugging process
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["my_dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["my_dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["my_dapui_config"] = function()
				dapui.close()
			end

			-- https://pepa.holla.cz/2022/02/02/debugging-go-in-neovim/
			-- require("dap-go").setup()
			dap.adapters.go = function(callback)
				local stdout = vim.loop.new_pipe(false)
				local handle
				local pid_or_err
				local port = 38679
				local dap_opts = {
					stdio = { nil, stdout },
					args = { "dap", "-l", "127.0.0.1:" .. port },
					detached = true,
				}
				handle, pid_or_err = vim.loop.spawn("dlv", dap_opts, function(code)
					stdout:close()
					handle:close()
					if code ~= 0 then
						print("dlv exited with code", code)
					end
				end)
				assert(handle, "Error running dlv: " .. tostring(pid_or_err))
				stdout:read_start(function(err, chunk)
					assert(not err, err)
					if chunk then
						vim.schedule(function()
							require("dap.repl").append(chunk)
						end)
					end
				end)
				-- Wait for delve to start
				vim.defer_fn(function()
					callback({ type = "server", host = "127.0.0.1", port = port })
				end, 100)
			end

			-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
			dap.configurations.go = {
				{
					type = "go",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
				{
					type = "go",
					name = "Debug test", -- configuration for debugging test files
					request = "launch",
					mode = "test",
					program = "${file}",
				},
				-- works with go.mod packages and sub packages
				{
					type = "go",
					name = "Debug test (go.mod)",
					request = "launch",
					mode = "test",
					program = "./${relativeFileDirname}",
				},
			}
		end,
	},
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		config = function()
			require("dap-go").setup({
				-- Additional dap configurations can be added.
				-- dap_configurations accepts a list of tables where each entry
				-- represents a dap configuration. For more details do:
				-- :help dap-configuration
				dap_configurations = {
					{
						-- Must be "go" or it will be ignored by the plugin
						type = "go",
						name = "Attach remote",
						mode = "remote",
						request = "attach",
					},
				},
				-- delve configurations
				delve = {
					-- time to wait for delve to initialize the debug session.
					-- default to 20 seconds
					initialize_timeout_sec = 20,
					path = "dlv",
					-- a string that defines the port to start delve debugger.
					-- default to string "${port}" which instructs nvim-dap
					-- to start the process in a random available port
					-- port = 38679,
				},
			})
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		config = function()
			-- Missing required fields in type `dapui.Config`: `element_mappings`, `expand_lines`, `force_buffers`, `layouts`, `controls`, `render`
			require("dapui").setup({
				-- Missing required fields in type `dapui.Config.icons`: `current_frame`
				icons = { expanded = "▾", collapsed = "▸" },
				mappings = {
					-- Use a table to apply multiple mappings
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
				},
				sidebar = {
					-- You can change the order of elements in the sidebar
					elements = {
						-- Provide as ID strings or tables with "id" and "size" keys
						{
							id = "scopes",
							size = 0.25, -- Can be float or integer > 1
						},
						{ id = "breakpoints", size = 0.25 },
						{ id = "stacks", size = 0.25 },
						{ id = "watches", size = 00.25 },
					},
					size = 40,
					position = "left", -- Can be "left", "right", "top", "bottom"
				},
				tray = {
					elements = { "repl" },
					size = 10,
					position = "bottom", -- Can be "left", "right", "top", "bottom"
				},
				floating = {
					max_height = nil, -- These can be integers or a float between 0 and 1.
					max_width = nil, -- Floats will be treated as percentage of your screen.
					border = "single", -- Border style. Can be "single", "double" or "rounded"
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
			})
		end,
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
	},
}
