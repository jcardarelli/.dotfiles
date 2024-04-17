--------------------------------------------------------------------------------
-- Globals
--------------------------------------------------------------------------------
-- Disable netrw at the very start of your init.lua (strongly advised)
-- https://github.com/nvim-tree/nvim-tree.lua#setup
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Use toggleterm with fish shell
vim.o.shell = "fish"

-- Folding
-- vim.g.foldmethod = "expr"
-- vim.g.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- set folds to be open on startup
vim.opt.foldlevel = 99

-- always keep the diagnostics 'sign column' open so there's no jarring
-- opening and closing with > 0 warnings/errors/etc
vim.opt.signcolumn = "yes"
-- vim.cmd.set('cmdheight=0')

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

--------------------------------------------------------------------------------
-- Add highlight for trailing whitespace
--------------------------------------------------------------------------------
-- vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")
-- TODO: highlight trailing whitespace in red
-- vim.opt.listchars:append("trail:█")
-- vim.cmd 'set listchars=eol:↵,trail:█,tab:>-,nbsp:␣ '
