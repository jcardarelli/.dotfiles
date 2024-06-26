--------------------------------------------------------------------------------
-- Globals
--------------------------------------------------------------------------------
-- Disable netrw at the very start of your init.lua (strongly advised)
-- https://github.com/nvim-tree/nvim-tree.lua#setup
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Check which client we're using: terminal or neovide
if vim.g.neovide then
	vim.o.guifont = "JetBrains Mono NL"
	vim.g.neovide_cursor_trail_size = 0
end

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

-- Autocommand to call the function when entering a buffer or window
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter", "VimResized" }, {
	callback = function()
		if vim.bo.filetype ~= "toggleterm" or "noice" or "NvimTree" or "Lazy" or "sagaoutline" then
			short_buffer_settings_toggle()
		end
	end,
	group = vim.api.nvim_create_augroup("ToggleLineNumbersGroup", { clear = true }),
})

-- Use toggleterm with fish shell
vim.o.shell = "fish"

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- set folds to be open on startup
vim.opt.foldlevel = 99

-- always keep the diagnostics 'sign column' open so there's no jarring
-- opening and closing with > 0 warnings/errors/etc
vim.opt.signcolumn = "yes"
-- vim.cmd.set('cmdheight=0')

-- Incremental search and substitution
vim.opt.inccommand = "split"

-- use regular line numbers for normal windows, disable line numbers for terminal
-- windows, and use cmdheight=0 to hide the empty cmd bar at the bottom (disabled
-- for filetype terminal in the lualine settings)
vim.cmd.set("number")

-- default opening positions for splits
vim.cmd.set("splitright")
vim.cmd.set("splitbelow")

vim.cmd.set("wildignore=*/node_modules/*,*/target/*,*/tmp/*")
vim.cmd.set("grepprg=rg\\ --vimgrep\\ --no-heading\\ --smart-case\\ --no-ignore-vcs")
vim.cmd.set("grepformat=%f:%l:%c:%m")
vim.cmd.set("dictionary=/usr/share/dict/words")

-- copy all yanked text to the system clipboard by default
vim.cmd.set("clipboard+=unnamedplus")

-- only break lines at whole words (good for writing text)
vim.cmd.set("linebreak")

--------------------------------------------------------------------------------
-- set the tab width to 4 spaces for all files that use tabs
--------------------------------------------------------------------------------
vim.cmd.set("tabstop=4")
vim.cmd.set("shiftwidth=4")
