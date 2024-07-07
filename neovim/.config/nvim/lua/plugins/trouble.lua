return {
	"folke/trouble.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	init = function()
		require("trouble").setup({})
	end,
}
