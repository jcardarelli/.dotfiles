return {
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
}
