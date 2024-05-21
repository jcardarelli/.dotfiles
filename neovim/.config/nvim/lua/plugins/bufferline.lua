return {
	"akinsho/bufferline.nvim",
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
