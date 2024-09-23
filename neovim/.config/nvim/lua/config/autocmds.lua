-- Set filetype to groovy if filename is Jenkinsfile
vim.api.nvim_create_autocmd({
	"BufRead",
	"BufNewFile",
}, {
	pattern = "Jenkinsfile",
	callback = function()
		vim.bo.filetype = "groovy"
	end,
})

-- Toggle settings based on buffer line count
local function short_buffer_settings_toggle()
	local total_lines = vim.api.nvim_buf_line_count(0)
	local window_height = vim.api.nvim_win_get_height(0)

	if total_lines <= window_height then
		vim.wo.number = false
		vim.wo.cursorline = false
	else
		vim.wo.number = true
		vim.wo.cursorline = true
	end
end
vim.api.nvim_create_autocmd({
	"BufEnter",
	"BufWinEnter",
	"VimResized",
	"WinEnter",
}, {
	callback = function()
		if
			vim.bo.filetype ~= "Lazy"
			and vim.bo.filetype ~= "neoterm"
			and vim.bo.filetype ~= "noice"
			and vim.bo.filetype ~= "NvimTree"
			and vim.bo.filetype ~= "sagaoutline"
			and vim.bo.filetype ~= "toggleterm"
		then
			short_buffer_settings_toggle()
		end
	end,
	group = vim.api.nvim_create_augroup("ToggleLineNumbersGroup", { clear = true }),
})

-- Allow nvr git commit windows to be closed with just :wq or :x
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit", "gitrebase", "gitconfig" },
	command = "set bufhidden=delete",
})
