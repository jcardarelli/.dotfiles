-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

-- leader key must be set for lazy
vim.g.mapleader = " "

-- load lazy
require("lazy").setup("plugins", {
	install = { colorscheme = { "tokyonight" } },
	defaults = { lazy = true },
	ui = {
		border = "rounded",
	},
	checker = { enabled = true, notify = false },
	debug = false,
})
