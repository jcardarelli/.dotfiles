return {
	{
		"tpope/vim-fugitive",
		event = { "VeryLazy" },
		cond = function()
			local output = vim.fn.systemlist("git rev-parse --is-inside-work-tree 2>/dev/null")
			return #output ~= 0
		end,
	},
	{
		"tpope/vim-unimpaired",
		lazy = false,
	},
}
