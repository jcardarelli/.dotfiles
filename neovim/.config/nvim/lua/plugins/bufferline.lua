return {
	-- https://www.reddit.com/r/neovim/comments/1ctx4z7/comment/l4fvgjs/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
	-- This replaces akinsho/bufferline.nvim, which seems to have broken with neovim 0.10
	"Theyashsawarkar/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "tabs",
			separator_style = "slant",
		},
	},
}
