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

-- Use toggleterm with fish shell
vim.o.shell = "fish"

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Set folds to be open on startup
vim.opt.foldlevel = 99

-- Always keep the diagnostics 'sign column' open so there's no jarring
-- opening and closing with > 0 warnings/errors/etc
vim.opt.signcolumn = "yes"
vim.cmd.set("cmdheight=0")

-- Default opening positions for splits
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

-- Copy all yanked text to the system clipboard by default
vim.cmd.set("clipboard+=unnamedplus")

-- Only break lines at whole words (good for writing text)
vim.cmd.set("linebreak")

-- Disable smartindent so that treesitter will not mess up file previews
vim.opt.smartindent = false
