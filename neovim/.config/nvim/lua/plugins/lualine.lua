-- Show macro recording message when using cmdheight=0
-- https://www.reddit.com/r/neovim/comments/xy0tu1/cmdheight0_recording_macros_message/
local function show_macro_recording()
	local recording_register = vim.fn.reg_recording()
	if recording_register == "" then
		return ""
	else
		return "Recording @" .. recording_register
	end
end

return {
	"nvim-lualine/lualine.nvim",
	init = function()
		require("lualine").setup({
			options = {
				theme = "tokyonight",
				component_separators = "",
				disabled_filetypes = {
					"Lazy",
					"NvimTree",
					"sagaoutline",
					"neoterm",
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
			sections = {
				lualine_b = {
					{
						"macro-recording",
						fmt = show_macro_recording,
					},
				},
			},
		})
	end,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
}
