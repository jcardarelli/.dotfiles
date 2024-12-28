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
			vim.bo.filetype ~= "lazy"
			and vim.bo.filetype ~= "neoterm"
			and vim.bo.filetype ~= "noice"
			and vim.bo.filetype ~= "NvimTree"
			and vim.bo.filetype ~= "sagaoutline"
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

-- Automatically navigate to the first unstaged git change, if present
vim.api.nvim_create_autocmd("User", {
	pattern = "GitSignsUpdate",
	callback = function()
		-- Only run once per buffer
		if vim.b.git_change_handled then
			return
		end

		-- Do not run for new changes to a file
		local status_dict = vim.b.gitsigns_status_dict
		if not status_dict or (status_dict.added == 0 and status_dict.changed == 0 and status_dict.removed == 0) then
			return
		end

		-- If the file has previous changes, navigate to the hunk and bring to the
		-- top of the window
		vim.api.nvim_buf_call(vim.api.nvim_get_current_buf(), function()
			require("gitsigns").next_hunk()
			vim.defer_fn(function()
				vim.api.nvim_command("normal! zt")
				vim.b.git_change_handled = true
			end, 100)
		end)
	end,
})

-- Reformat nvim-cmp docs with treesitter
-- https://www.reddit.com/r/neovim/comments/180fmw5/comment/ka8of5r/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
vim.api.nvim_create_autocmd("FileType", {
	pattern = "cmp_docs",
	callback = function()
		vim.treesitter.start(0, "markdown")
	end,
})
