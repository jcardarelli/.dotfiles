return {
	-- Colorscheme
	"folke/tokyonight.nvim",
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					theme = "tokyonight",
					component_separators = "",
					disabled_filetypes = {
						"Lazy",
						"NvimTree",
						"sagaoutline",
						"toggleterm",
					},

					-- If current filetype is in this list it'll always be drawn as inactive
					-- statusline and the last window will be drawn as active statusline. For
					-- example if you don't want statusline of your file tree / sidebar window
					-- to have active statusline you can add their filetypes here.
					ignore_focus = {
						"dap-repl",
						"dapui_breakpoints",
						"dapui_console",
						"dapui_scopes",
						"dapui_stacks",
						"dapui_watches",
					},
				},
			})
		end,
		dependencies = { "nvim-tree/nvim-web-devicons", opt = false },
	},
}
