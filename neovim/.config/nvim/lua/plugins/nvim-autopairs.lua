return {
	"windwp/nvim-autopairs",
	config = function()
		require("nvim-autopairs").setup({
			-- if next character is a close pair and it doesn't have an open pair in same line, then it will not add a close pair
			enable_check_bracket_line = true,
		})
	end,
}
