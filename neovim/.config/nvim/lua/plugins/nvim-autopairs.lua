return {
	"windwp/nvim-autopairs",
	dependencies = {
		"windwp/nvim-ts-autotag",
		init = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
			})
		end,
	}, -- html autopairs
	config = function()
		require("nvim-autopairs").setup({
			-- if next character is a close pair and it doesn't have an open pair in same line, then it will not add a close pair
			enable_check_bracket_line = true,
		})
	end,
}
