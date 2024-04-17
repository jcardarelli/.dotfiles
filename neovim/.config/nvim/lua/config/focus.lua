-- Disable focus for NvimTree
-- https://github.com/nvim-focus/focus.nvim?tab=readme-ov-file#disabling-focus
local ignore_filetypes = { 'NvimTree', 'toggleterm' }
local ignore_buftypes = { 'nofile', 'prompt', 'popup' }

local augroup =
	vim.api.nvim_create_augroup('FocusDisable', { clear = true })

vim.api.nvim_create_autocmd('WinEnter', {
	group = augroup,
	callback = function(_)
		if vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
		then
			vim.w.focus_disable = true
		else
			vim.w.focus_disable = false
		end
	end,
	desc = 'Disable focus autoresize for BufType',
})

vim.api.nvim_create_autocmd('FileType', {
	group = augroup,
	callback = function(_)
		if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
			vim.b.focus_disable = true
		else
			vim.b.focus_disable = false
		end
	end,
	desc = 'Disable focus autoresize for FileType',
})

require("focus").setup()