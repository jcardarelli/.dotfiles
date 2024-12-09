--------------------------------------------------------------------------------
--- Environment variables
--------------------------------------------------------------------------------
-- https://github.com/mhinz/neovim-remote?tab=readme-ov-file#typical-use-cases
vim.env.GIT_EDITOR = "nvr --remote-wait"

--------------------------------------------------------------------------------
-- Globals
--------------------------------------------------------------------------------
-- Disable netrw at the very start of your init.lua (strongly advised)
-- https://github.com/nvim-tree/nvim-tree.lua#setup
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.tabstop = 4

-- Support mouse movement events
vim.opt.mousemoveevent = true

-- Automatically reload a buffer on git checkout
vim.opt.autoread = true

-- Check which client we're using: terminal or neovide
if vim.g.neovide then
	vim.o.guifont = "JetBrains Mono NL"
	vim.g.neovide_cursor_trail_size = 0
end

-- Use fish shell with terminal
vim.o.shell = "fish"

-- Buffers
vim.opt.switchbuf = "useopen"

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Set folds to be open on startup
vim.opt.foldlevel = 99

-- Always keep the diagnostics 'sign column' open so there's no jarring
-- opening and closing with > 0 warnings/errors/etc
vim.opt.signcolumn = "yes"

-- Disable OG vim's cmd bar that usually lives below the lualine. I'm using
-- folke/noice.nvim instead. There's some custom code in this config that
-- shows when recording a new macro, which is really the only missing
-- functionality when this setting is enabled.
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

-- When "on" the commands listed below move the cursor to the first non-blank of the line.  When off the cursor is kept in the same column (if possible).  This applies to the commands: CTRL-D, CTRL-U, CTRL-B, CTRL-F, "G", "H", "M", "L", gg, and to the commands "d", "<<" and ">>" with a linewise operator, with "%" with a count and to buffer changing commands (CTRL-^, :bnext, :bNext, etc.).
vim.cmd.set("startofline")
