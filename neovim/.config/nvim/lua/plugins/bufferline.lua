return {
	-- https://www.reddit.com/r/neovim/comments/1ctx4z7/comment/l4fvgjs/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
	-- This replaces akinsho/bufferline.nvim, which seems to have broken with neovim 0.10
	"Theyashsawarkar/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	config = function()
		require("bufferline").setup({
			options = {
				offsets = {
					{
						filetype = "NvimTree",
						highlight = "Directory",
						separator = true,
						text = "",
						text_align = "left",
					},
				},
				always_show_bufferline = true,
				mode = "tabs",
				separator_style = "thin",
				numbers = "buffer_id",
				-- indicator icons
				show_tab_indicators = true,
				buffer_close_icon = "󰅖",
				modified_icon = "●",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
			},
		})
	end,
}
