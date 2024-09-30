return {
	"Wansmer/sibling-swap.nvim",
	event = "BufReadPre",
	config = function()
		require("sibling-swap").setup({
			use_default_keymaps = false,
			keymaps = {
				["<C-.>"] = "swap_with_right",
				["<C-,>"] = "swap_with_left",
				["<space>."] = "swap_with_right_with_opp",
				["<space>,"] = "swap_with_left_with_opp",
			},
		})
	end,
}
