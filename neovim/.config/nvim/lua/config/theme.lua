--------------------------------------------------------------------------------
-- Current theme settings
--------------------------------------------------------------------------------
vim.opt.termguicolors = true
vim.opt.background = "dark"
-- https://github.com/neovim/neovim/issues/18201#issuecomment-1382075049
vim.api.nvim_cmd({
	cmd = "colorscheme",
	args = { "tokyonight" },
}, {})
