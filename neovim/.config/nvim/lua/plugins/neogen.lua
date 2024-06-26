return {
	"danymat/neogen",
	init = function()
		require("neogen").setup({
			enabled = true,
			input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
			-- jump_map = "<C-e>"       -- (DROPPED SUPPORT, see [here](#cycle-between-annotations) !) The keymap in order to jump in the annotation fields (in insert mode)
		})
	end,
	dependencies = "nvim-treesitter/nvim-treesitter",
}
