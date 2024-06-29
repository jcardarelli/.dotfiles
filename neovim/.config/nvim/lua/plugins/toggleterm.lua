return {
	-- Toggleterm runs shell commands using vim mappings
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = "ToggleTerm",
	init = function()
		local colors = require("tokyonight.colors").setup()
		require("toggleterm").setup({
			-- automatically scroll to the bottom on terminal output
			auto_scroll = true,

			-- hide the number column in toggleterm buffers
			hide_number = true,

			-- highlights which map to a highlight group name and a table of it's values
			highlights = {
				Normal = {
					guibg = colors.bg_dark,
				},
			},

			-- if set to true (default) the previous terminal mode will be remembered
			persist_mode = true,

			-- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
			shade_terminals = false,

			-- the degree by which to darken to terminal color. default: 1 for dark backgrounds, 3 for light
			shading_factor = 1,
			start_in_insert = true,
		})
	end,
}
