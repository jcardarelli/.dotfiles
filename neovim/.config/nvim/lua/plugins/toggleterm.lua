return {
	"akinsho/toggleterm.nvim",
	version = "*",
	-- keys = {
	-- 	{
	-- 		"<C-\\>",
	-- 		":ToggleTerm direction=vertical size=84<CR>",
	-- 	},
	-- },
	cmd = "ToggleTerm",
	config = function()
		-- Toggleterm runs shell commands using vim mappings
		local colors = require("tokyonight.colors").setup()
		require("toggleterm").setup({
			-- HACK: This fixes the issue with toggleterm not setting a dark background
			--       for the terminal when shade_terminals is enabled
			-- https://github.com/akinsho/toggleterm.nvim/issues/119#issuecomment-1507797135
			highlights = {
				Normal = {
					guibg = colors.bg_dark,
				},
			},
			shade_terminals = false,

			-- the degree by which to darken to terminal color
			-- default: 1 for dark backgrounds, 3 for light
			shading_factor = 1,

			auto_scroll = true,

			-- if set to true (default) the previous terminal mode will be remembered
			persist_mode = true,

			-- -- hide the number column in toggleterm buffers
			-- hide_number = true,
			start_in_insert = true,
		})
	end,
}
