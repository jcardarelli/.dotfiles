--------------------------------------------------------------------------------
-- Globals
--------------------------------------------------------------------------------
-- Disable netrw at the very start of your init.lua (strongly advised)
-- https://github.com/nvim-tree/nvim-tree.lua#setup
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.tabstop = 4

-- Automatically reload a buffer on git checkout
vim.opt.autoread = true

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
		if
			vim.bo.filetype ~= "toggleterm"
			and vim.bo.filetype ~= "noice"
			and vim.bo.filetype ~= "NvimTree"
			and vim.bo.filetype ~= "Lazy"
			and vim.bo.filetype ~= "sagaoutline"
		then
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
vim.cmd.set("cmdheight=0")

-- default opening positions for splits
vim.cmd.set("splitright")
vim.cmd.set("splitbelow")

vim.opt.wildignore = {
	"*.o",
	"*.a",
	"__pycache__",
	"*/node_modules/*",
	"*/target/*",
	"*/tmp/*",
}
vim.cmd.set("grepprg=rg\\ --vimgrep\\ --no-heading\\ --smart-case\\ --no-ignore-vcs")
vim.cmd.set("grepformat=%f:%l:%c:%m")
vim.cmd.set("dictionary=/usr/share/dict/words")

-- copy all yanked text to the system clipboard by default
vim.cmd.set("clipboard+=unnamedplus")

-- only break lines at whole words (good for writing text)
vim.cmd.set("linebreak")

-- disable smartindent so that treesitter will not mess up file previews
vim.opt.smartindent = false
