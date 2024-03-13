return {
	{
		"hrsh7th/nvim-cmp",
		opts = {
			sources = {
				-- other sources
				{
					name = "html-css",
					option = {
						-- your configuration here
					},
				},
			},
		},
	},
	{
		"Jezda1337/nvim-html-css",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim"
		},
		config = function()
			require("html-css"):setup()
		end
	}
}
