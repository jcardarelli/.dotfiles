return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	event = "LspAttach",
	config = function()
		require("bufferline").setup({
			options = {
				offsets = {
					{
						filetype = "NvimTree",
						highlight = "Directory",
						separator = false,
						text = "",
						text_align = "left",
					},
				},
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
				always_show_bufferline = true,
				separator_style = "thin",
				numbers = "buffer_id",
				diagnostics = "nvim_lsp",
				--- count is an integer representing total count of errors
				--- level is a string "error" | "warning"
				--- this should return a string
				--- Don't get too fancy as this function will be executed a lot
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or ""
					return " " .. icon .. count
				end,
				-- indicator icons
				show_tab_indicators = true,
				buffer_close_icon = "",
				modified_icon = "●",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
			},
		})
	end,
}
