-- https://www.reddit.com/r/neovim/comments/1ctx4z7/comment/l4fvgjs/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
-- This replaces akinsho/bufferline.nvim, which seems to have broken with neovim 0.10
-- Replace this plugin with the non-forked version once this fix is introduced:
-- https://github.com/akinsho/bufferline.nvim/compare/main...Theyashsawarkar:bufferline.nvim:main
-- Watch the get_component_size function for updates:
-- https://github.com/akinsho/bufferline.nvim/blob/main/lua/bufferline/ui.lua#L119
return {
	"akinsho/bufferline.nvim",
	-- "Theyashsawarkar/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	init = function()
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
